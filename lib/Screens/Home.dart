import 'dart:developer';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../Models/Recipe.dart';
import '../Services/RecipeService/RecipeService.dart';
import '../States/HomeState.dart';
import '../States/UserState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/LoadingCard.dart';
import '../Widgets/carouselSlider.dart';
import '../Widgets/clickableCardWidget.dart';
import 'RecipeDetailsPage.dart';

class Home extends StatelessWidget {
  Home({key});

  List<String> cuisines = [
    StringSet.americanText,
    StringSet.chineseText,
    StringSet.japaneseText,
    StringSet.indianText,
    StringSet.frenchText,
    StringSet.italianText,
    StringSet.middleEasternText,
    StringSet.mexicanText,
    StringSet.thaiText
  ];

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context, listen: true);
    final userState = Provider.of<UserState>(context, listen: true);
    RecipeService service = RecipeService();

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                StringSet.homeTitle + userState.username,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              StringSet.homeDescription,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            CarouselSliderTeif(email: userState.email),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  StringSet.howAreYouFeelingTitle,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    log("boy");
                  },
                  child: const Text(
                    StringSet.viewMoreText,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: ColorSet.primaryColor),
                  ),
                ),
              ],
            ),
            ChipsChoice.single(
              value: homeState.tag,
              onChanged: (val) async {
                homeState.changeTag(val);
                await homeState.changeRecipes(cuisines[val]);
              },
              choiceItems: C2Choice.listFrom(
                  source: cuisines,
                  value: (index, item) => index,
                  label: (index, item) => item),
              wrapped: false,
              choiceActiveStyle: const C2ChoiceStyle(
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  backgroundColor: ColorSet.primaryColor,
                  color: ColorSet.whiteColor,
                  borderColor: Colors.transparent,
                  showCheckmark: false),
              choiceStyle: C2ChoiceStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? ColorSet.darkGrayColor
                      : ColorSet.darkWhiteColor,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? ColorSet.darkWhiteColor
                          : ColorSet.darkGrayColor,
                  borderColor: Colors.transparent,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<Recipe>>(
                future: service.getRecipesByCuisineType(
                    cuisines[homeState.tag], userState.email),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    homeState.recipesByCuisineType = snapshot.data;
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(snapshot.data.length, (index) {
                        return ClickableCard(
                            imagePath:
                                homeState.recipesByCuisineType[index].image,
                            text: homeState.recipesByCuisineType[index].title,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        RecipeDetailsPage(
                                            recipeId: homeState
                                                .recipesByCuisineType[index]
                                                .id),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        SmartCookAnimation.PageRouteAnimation(
                                            animation, child),
                                  ));
                            });
                      }),
                    );
                  } else {
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(8, (index) {
                        return LoadingCard(
                            width: MediaQuery.of(context).size.height / 4,
                            height: MediaQuery.of(context).size.height / 4.5);
                      }),
                    );
                  }
                })
          ],
        ),
      )),
    );
  }
}

class MySharedPreferences {
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username") ?? "cook";
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? "cook@gmail.com";
  }
}
