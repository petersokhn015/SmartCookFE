import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/UserService/UserService.dart';
import '../States/SetPreferencesState.dart';
import '../States/UserState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/CustomStepper.dart';
import '../Widgets/appButton.dart';
import 'MainPage.dart';

class Intolerance extends StatelessWidget {
  const Intolerance({key});

  @override
  Widget build(BuildContext context) {
    UserService service = UserService();
    final userState = Provider.of<UserState>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Intolerance",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Consumer<SetPreferencesState>(
            builder: (context, prefs, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 80),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        StringSet.intoleranceTitle,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ChipsChoice<String>.multiple(
                      value: prefs.intoleranceTags,
                      onChanged: (val) {
                        prefs.addIntolerance(val);
                      },
                      choiceItems: C2Choice.listFrom(
                          source: prefs.intolerance,
                          value: (index, item) => item,
                          label: (index, item) => item),
                      wrapped: true,
                      choiceActiveStyle: const C2ChoiceStyle(
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          backgroundColor: ColorSet.primaryColor,
                          borderColor: Colors.transparent,
                          color: ColorSet.whiteColor,
                          showCheckmark: false),
                      choiceStyle: C2ChoiceStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? ColorSet.darkGrayColor
                                  : ColorSet.darkWhiteColor,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? ColorSet.darkWhiteColor
                                  : ColorSet.darkGrayColor,
                          borderColor: Colors.transparent,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: AppButton(
                          text: StringSet.finishText,
                          onClicked: () async {
                            final preferences =
                                await SharedPreferences.getInstance();
                            String email = preferences.getString("email");

                            userState.setUserPreferences(prefs.intoleranceTags,
                                prefs.cuisineTags, prefs.diet);
                            bool isSuccess = await service.getDietSuggestions(
                                email,
                                prefs.diet,
                                prefs.intoleranceTags,
                                prefs.cuisineTags);

                            if (isSuccess) {
                              final user = await service.getUserInfo(email);
                              userState.setUserInformation(user);
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        MainPage(),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        SmartCookAnimation.PageRouteAnimation(
                                            animation, child),
                                  ));
                            }
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomStepper(numPage: 3),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
