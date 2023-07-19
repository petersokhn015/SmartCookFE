import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../States/SetPreferencesState.dart';
import '../States/UserState.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';

class MyPreferences extends StatelessWidget {
  const MyPreferences({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: true);
    List<String> diets = [userState.userPrefs.diet];
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorSet.primaryColor,
            child: Icon(Icons.edit),
            onPressed: () {},
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "My Preferences",
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "This is a quick overview of your preferences. If you want to change something, press the edit icon.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Meal Type",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Chip(
                        label: Text(userState.userPrefs.diet),
                        backgroundColor: ColorSet.primaryColor,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Cuisine Types",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ChipsChoice<String>.multiple(
                      value: userState.userPrefs.cuisineTypes,
                      onChanged: (val) {},
                      choiceItems: C2Choice.listFrom(
                          source: userState.userPrefs.cuisineTypes,
                          value: (index, item) => item,
                          label: (index, item) => item),
                      wrapped: true,
                      choiceActiveStyle: const C2ChoiceStyle(
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          backgroundColor: ColorSet.primaryColor,
                          color: ColorSet.whiteColor,
                          showCheckmark: false),
                      choiceStyle: const C2ChoiceStyle(
                          color: ColorSet.darkGrayColor,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Intolerances",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ChipsChoice<String>.multiple(
                      value: userState.userPrefs.intolerances,
                      onChanged: (val) {},
                      choiceItems: C2Choice.listFrom(
                          source: userState.userPrefs.intolerances,
                          value: (index, item) => item,
                          label: (index, item) => item),
                      wrapped: true,
                      choiceActiveStyle: const C2ChoiceStyle(
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          backgroundColor: ColorSet.primaryColor,
                          color: ColorSet.whiteColor,
                          showCheckmark: false),
                      choiceStyle: const C2ChoiceStyle(
                          color: ColorSet.darkGrayColor,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
