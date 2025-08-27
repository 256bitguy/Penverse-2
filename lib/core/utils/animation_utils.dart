import 'package:flutter/material.dart';

class AnimationUtils {
  static Duration get defaultDuration => const Duration(milliseconds: 300);
  static Duration get longDuration => const Duration(milliseconds: 500);
  static Curve get defaultCurve => Curves.easeOutCubic;
  
  static Widget slideTransition({
    required Widget child,
    required Animation<double> position,
    SlideDirection direction = SlideDirection.right,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: direction.offset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: position,
        curve: defaultCurve,
      )),
      child: child,
    );
  }

  static Widget fadeTransition({
    required Widget child,
    required Animation<double> position,
  }) {
    return FadeTransition(
      opacity: position,
      child: child,
    );
  }

  static Widget fadeSlideTransition({
    required Widget child,
    required Animation<double> position,
    SlideDirection direction = SlideDirection.right,
  }) {
    return fadeTransition(
      position: position,
      child: slideTransition(
        position: position,
        direction: direction,
        child: child,
      ),
    );
  }
}

enum SlideDirection {
  left(Offset(-0.25, 0)),
  right(Offset(0.25, 0)),
  up(Offset(0, 0.25)),
  down(Offset(0, -0.25));

  final Offset offset;
  const SlideDirection(this.offset);
}