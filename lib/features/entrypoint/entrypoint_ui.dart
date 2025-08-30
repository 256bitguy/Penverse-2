import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

import '../home/presentation/screens/home_screen.dart';

import '../subjects/subject/ui/subject_list.dart';
import './component/app_navigation_bar.dart';
import '../currentaffairs/presentation/screens/daily_ga_ui.dart';
import '../currentaffairs/presentation/screens/daily_vocab.dart';
import '../currentaffairs/presentation/screens/daily_editorial.dart';

/// This page will contain all the bottom navigation tabs
class EntryPointUI extends StatefulWidget {
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  /// Current Page
  int currentIndex = 0;

  /// On labelLarge navigation tap
  void onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  List<Widget> pages = [
    const HomePage(),
    const SubjectsScreen(id: 1),
    const ParagraphScreen(),
    const DailyScreen(),
    const DailyVocabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
