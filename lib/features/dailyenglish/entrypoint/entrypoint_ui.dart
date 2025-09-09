import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';

import '../editorials/ui/daily_editorial.dart';
 
import '../vocabulary/ui/daily_vocab.dart';
import './component/app_navigation_bar.dart';
import '../phrasalVerbs/ui/daily_phrasal_verbs.dart';
import '../idioms/ui/daily_idioms.dart';
 
class EntryPointEnglish extends StatefulWidget {
  const EntryPointEnglish({super.key});

  @override
  State<EntryPointEnglish> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointEnglish> {
  int currentIndex = 0;

  void onBottomNavigationTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> pages = const [
    DailyVocabScreen(topicId: ""),
    ParagraphScreen(),
    DailyPhrasalVerbScreen(topicId: "",),
    DailyIdiomsScreen(topicId: ""),
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
