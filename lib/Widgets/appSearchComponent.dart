import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class AppSearchComponent extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Color color;

  const AppSearchComponent({key, this.text, this.imageUrl, this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: color,
        ),
        child: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: ColorSet.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Transform.translate(
                offset: const Offset(20, 20),
                child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(90),
                    child: Image.asset(
                      imageUrl,
                      width: 120,
                      height: 120,
                    )),
              )),
        ]),
      ),
    );
  }
}
