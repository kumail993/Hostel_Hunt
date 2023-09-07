import 'package:flutter/material.dart';
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Use the fade effect instead of sliding
      var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
  );
}