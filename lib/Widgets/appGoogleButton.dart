import 'package:flutter/material.dart';

import '../Utils/colors.dart';
import '../Utils/strings.dart';

class AppGoogleButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const AppGoogleButton({key, this.text, this.onClicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 13,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorSet.darkWhiteColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
          onPressed: onClicked,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImageUrls.googleURL),
              Text(
                text,
                style: const TextStyle(
                    color: ColorSet.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
