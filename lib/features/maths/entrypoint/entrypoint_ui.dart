import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';

import './component/app_navigation_bar.dart';

import '../../maths/addition/addition.dart';
import '../../maths/multiplication/multiplication.dart';
import '../../maths/subtraction/subtraction.dart';
import '../../maths/fraction/fraction_converter.dart';
import '../../maths/square/square.dart';

/// This page will contain all the bottom navigation tabs
class EntryPointMaths extends StatefulWidget {
  const EntryPointMaths({super.key});

  @override
  State<EntryPointMaths> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointMaths> {
  int currentIndex = 0;

  void onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  List<Widget> pages = [
    AdditionQuiz(),
    SubtractionQuiz(),
    MultiplicationQuiz(),
    FractionDecimalQuiz(),
    SquareQuiz()
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevents default back (exit app)
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // 👇 Navigate back to first navigation page
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              fillColor: AppColors.scaffoldBackground,
              child: child,
            );
          },
          duration: AppDefaults.duration,
          child: pages[currentIndex],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: currentIndex,
          onNavTap: onBottomNavigationTap,
        ),
      ),
    );
  }
}
