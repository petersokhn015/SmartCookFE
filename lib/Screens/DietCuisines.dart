import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../States/SetPreferencesState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/CustomStepper.dart';
import '../Widgets/appButton.dart';
import 'Intolerances.dart';

class DietCuisines extends StatelessWidget {
  const DietCuisines({key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Diet & Cuisine",
                style: Theme.of(context).textTheme.headlineMedium),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        StringSet.dietTitle,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ChipsChoice.single(
                      value: prefs.tag,
                      onChanged: (val) {
                        prefs.addDiet(val);
                      },
                      choiceItems: C2Choice.listFrom(
                          source: prefs.diets,
                          value: (index, item) => index,
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
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        StringSet.cuisineTypeTitle,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ChipsChoice<String>.multiple(
                      value: prefs.cuisineTags,
                      onChanged: (val) {
                        prefs.addCuisine(val);
                      },
                      choiceItems: C2Choice.listFrom(
                          source: prefs.cuisines,
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
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppButton(
                          text: StringSet.continueText,
                          onClicked: () async {
                            final preferences =
                                await SharedPreferences.getInstance();
                            preferences.setStringList(
                                "cuisines", prefs.cuisineTags);
                            preferences.setString("diet", prefs.diet);
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Intolerance(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      SmartCookAnimation.PageRouteAnimation(
                                          animation, child),
                                ));
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomStepper(numPage: 2),
                    const SizedBox(
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
