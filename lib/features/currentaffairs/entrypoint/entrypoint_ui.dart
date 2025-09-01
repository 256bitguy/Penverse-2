import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import './component/app_navigation_bar.dart';
import '../../currentaffairs/generalAwareness/ui/banking_awareness.dart';
import '../../currentaffairs/upscAwareness/ui/upsc_awareness.dart';
class EntryPointCA extends StatefulWidget {
  const EntryPointCA({super.key});

  @override
  State<EntryPointCA> createState() => _EntryPointCAState();
}

class _EntryPointCAState extends State<EntryPointCA> {
  int currentIndex = 0;

  void onBottomNavigationTap(int index) {
    setState(() => currentIndex = index);
  }

  final List<Widget> pages = const [
    DailyNewsScreen(),
    DailyAffairsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // 👇 same logic as EntryPointEnglish
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
        floatingActionButtonLocation: 
            FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: currentIndex,
          onNavTap: onBottomNavigationTap,
        ),
      ),
    );
  }
}
