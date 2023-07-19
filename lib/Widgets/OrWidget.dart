import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Utils/colors.dart';
import '../Utils/strings.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2.65,
          height: MediaQuery.of(context).size.height / 1500,
          color: ColorSet.primaryColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 6.8,
          height: MediaQuery.of(context).size.height / 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: ColorSet.primaryColor,
          ),
          child: const Center(
            child: Text(
              StringSet.orText,
              style: TextStyle(
                fontSize: 18.0,
                color: ColorSet.whiteColor,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2.65,
          height: MediaQuery.of(context).size.height / 1500,
          color: ColorSet.primaryColor,
        ),
      ],
    );
  }
}
