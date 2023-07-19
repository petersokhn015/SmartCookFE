import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:detecttestapppp/Screens/GeneralSettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/UserPreferences.dart';
import '../Services/UserService/UserService.dart';
import '../States/UserState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/ClickableContainerProfile.dart';
import '../Widgets/ClickableContainerWithDescProfile.dart';
import 'MyPreferences.dart';

class Profile extends StatelessWidget {
  const Profile({key});

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: true);
    UserService service = UserService();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                userState.username,
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              userState.email,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                log("boy");
                              },
                              child: const Text(
                                StringSet.editYourProfileText,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: ColorSet.primaryColor),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: CachedNetworkImage(
                              imageUrl: userState.profileImage,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClickableContainerWithDescProfile(
                      title: StringSet.myFoodPreferencesTitle,
                      description: StringSet.myFoodPreferencesDescription,
                      topLeft: 10,
                      topRight: 10,
                      bottomLeft: 0,
                      bottomRight: 0,
                      onPressed: () async {
                        UserPreferences preferences =
                            await service.getUserPreferences(userState.email);
                        userState.setUserPreferences(preferences.intolerances,
                            preferences.cuisineTypes, preferences.diet);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      MyPreferences(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SmartCookAnimation.PageRouteAnimation(
                                      animation, child),
                            ));
                      }),
                  ClickableContainerWithDescProfile(
                      title: StringSet.myFavoriteRecipesTitle,
                      description: StringSet.myFavoriteRecipesDescription,
                      topLeft: 0,
                      topRight: 0,
                      bottomLeft: 10,
                      bottomRight: 10,
                      onPressed: () {}),
                  const SizedBox(
                    height: 40,
                  ),
                  ClickableContainerProfile(
                      title: StringSet.generalSettingsTitle,
                      topLeft: 10,
                      topRight: 10,
                      bottomLeft: 0,
                      bottomRight: 0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      GeneralSettings(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SmartCookAnimation.PageRouteAnimation(
                                      animation, child),
                            ));
                      }),
                  ClickableContainerProfile(
                      title: StringSet.aboutSmartCookTitle,
                      topLeft: 0,
                      topRight: 0,
                      bottomLeft: 0,
                      bottomRight: 0,
                      onPressed: () {}),
                  ClickableContainerProfile(
                      title: StringSet.logoutTitle,
                      topLeft: 0,
                      topRight: 0,
                      bottomLeft: 10,
                      bottomRight: 10,
                      onPressed: () {}),
                ],
              )),
        ),
      ),
    );
  }
}
