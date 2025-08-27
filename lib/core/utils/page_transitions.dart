import 'package:flutter/material.dart';
import 'animation_utils.dart';

class FadeSlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;

  FadeSlidePageRoute({
    required this.page,
    this.direction = SlideDirection.right,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AnimationUtils.fadeSlideTransition(
              position: animation,
              direction: direction,
              child: child,
            );
          },
          transitionDuration: AnimationUtils.defaultDuration,
          reverseTransitionDuration: AnimationUtils.defaultDuration,
        );
}