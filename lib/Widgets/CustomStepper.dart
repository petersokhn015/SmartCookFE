import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Utils/colors.dart';

class CustomStepper extends StatefulWidget {
  final int numPage;
  CustomStepper({key, this.numPage});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 4; i++)
          Container(
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: i == widget.numPage
                  ? ColorSet.primaryColor
                  : Theme.of(context).brightness == Brightness.light
                      ? ColorSet.darkWhiteColor
                      : ColorSet.darkGrayColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 30,
            ),
          ),
      ],
    );
  }
}
