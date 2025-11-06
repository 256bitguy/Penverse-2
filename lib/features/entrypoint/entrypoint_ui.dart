import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

import '../home/presentation/screens/home_screen.dart';

import '../subjects/subject/ui/subject_list.dart';
import './component/app_navigation_bar.dart';

import '../dailyenglish/entrypoint/entrypoint_ui.dart';
import '../dailyenglish/editorials/ui/daily_editorial.dart';
import '../currentaffairs/entrypoint/entrypoint_ui.dart';
import '../maths/entrypoint/entrypoint_ui.dart';

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
    if (index == 2) {
      // 👇 Replace first nav with second nav
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EntryPointEnglish()),
      );
    } else {
      setState(() => currentIndex = index);
    }
    if (index == 3) {
      // 👇 Replace first nav with second nav
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EntryPointCA()),
      );
    } else {
      setState(() => currentIndex = index);
    }
    if (index == 4) {
      // 👇 Replace first nav with second nav
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EntryPointMaths()),
      );
    } else {
      setState(() => currentIndex = index);
    }
    currentIndex = index;
    setState(() {});
  }

  List<Widget> pages = [
    const HomePage(),
    const SubjectsScreen(id: 1),
    const ParagraphScreen(),
    const EntryPointCA(),
     
    const EntryPointMaths(),
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
