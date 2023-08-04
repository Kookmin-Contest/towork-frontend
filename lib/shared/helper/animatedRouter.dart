import 'package:flutter/material.dart';
import 'package:gotowork/shared/menu_main.dart';

Route fadeRoute(dynamic screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return fade(child, animation);
    },
  );
}

Widget fade(Widget child, animation) {
  var tween = Tween(
    begin: 0.0,
    end: 1.0,
  ).chain(CurveTween(curve: Curves.ease));
  return FadeTransition(opacity: animation.drive(tween), child: child);
}

Route horizontalSlidingRoute(dynamic screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
