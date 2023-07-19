import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Utils/colors.dart';

class ClickableContainerWithDescProfile extends StatelessWidget {
  final String title;
  final String description;
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final VoidCallback onPressed;

  ClickableContainerWithDescProfile(
      {key,
      this.title,
      this.description,
      this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight)),
        color: Theme.of(context).brightness == Brightness.light
            ? ColorSet.darkWhiteColor
            : ColorSet.darkGrayColor,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? ColorSet.darkGrayColor
                            : ColorSet.darkWhiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? ColorSet.darkGrayColor
                            : ColorSet.darkWhiteColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.chevron_right,
                color: ColorSet.primaryColor,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
