import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
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
      color: AppColors.scaffoldBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            name: 'vocabulary',
            iconLocation: 'assets/icons/home.svg',
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
          ),
          BottomAppBarItem(
            name: 'Editorial',
            iconLocation: AppIcons.menu,
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
          ),
           
          BottomAppBarItem(
            name: 'Phrases',
            iconLocation: AppIcons.profile,
            isActive: currentIndex == 2,
            onTap: () => onNavTap(2),
          ),

          BottomAppBarItem(
            name: 'Idioms',
            iconLocation: AppIcons.save,
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
          ),
          
        ],
      ),
    );
  }
}
