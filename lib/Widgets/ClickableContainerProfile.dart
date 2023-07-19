import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Utils/colors.dart';

class ClickableContainerProfile extends StatelessWidget {
  final String title;
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final VoidCallback onPressed;
  const ClickableContainerProfile(
      {key,
      this.title,
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
                child: Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? ColorSet.darkGrayColor
                        : ColorSet.darkWhiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
