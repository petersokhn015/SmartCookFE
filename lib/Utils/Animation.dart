import 'package:flutter/material.dart';

class SmartCookAnimation {
  static SlideTransition PageRouteAnimation(animation, child) {
    var begin = Offset(1.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
