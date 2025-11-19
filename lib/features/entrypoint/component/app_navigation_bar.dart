import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import './bottom_app_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.cardBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
  BottomAppBarItem(
    name: 'Home',
    icon: Icons.home,
    isActive: currentIndex == 0,
    onTap: () => onNavTap(0),
  ),

  BottomAppBarItem(
    name: 'My Library',
    icon: Icons.menu_book,
    isActive: currentIndex == 1,
    onTap: () => onNavTap(1),
  ),

  BottomAppBarItem(
    name: 'Wordly',
    icon: Icons.edit_note,
    isActive: currentIndex == 2,
    onTap: () => onNavTap(2),
  ),

  BottomAppBarItem(
    name: 'News',
    icon: Icons.article,
    isActive: currentIndex == 3,
    onTap: () => onNavTap(3),
  ),

  BottomAppBarItem(
    name: 'Quiz',
    icon: Icons.quiz,
    isActive: currentIndex == 4,
    onTap: () => onNavTap(4),
  ),
]

      ),
    );
  }
}
