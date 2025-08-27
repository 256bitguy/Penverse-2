import 'package:flutter/material.dart';

class AnimatedContent extends StatelessWidget {
  final Widget child;
  final bool isForward;

  const AnimatedContent({
    super.key,
    required this.child,
    this.isForward = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            (isForward ? 1 - value : value - 1) * MediaQuery.of(context).size.width * 0.3,
            0,
          ),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}