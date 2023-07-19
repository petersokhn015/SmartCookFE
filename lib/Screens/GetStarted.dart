import 'package:flutter/material.dart';

import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/appButton.dart';
import 'SignUp.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: const [
                Text(
                  StringSet.welcomeTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: ColorSet.primaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  StringSet.welcomeDescription,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Stack(
              children: [
                Image.asset(ImageUrls.pandaSittingURL),
                Positioned(
                    left: 0,
                    bottom: MediaQuery.of(context).size.height / 8,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppButton(
                        text: StringSet.getStartedText,
                        onClicked: () async {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        SignUp(),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    SmartCookAnimation.PageRouteAnimation(
                                        animation, child),
                              ));
                        },
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
