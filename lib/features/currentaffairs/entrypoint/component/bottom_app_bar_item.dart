import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/constants.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.iconLocation,
    required this.name,
    required this.isActive,
    required this.onTap,
  });

  final String iconLocation;
  final String name;
  final bool isActive;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded( // ✅ makes it take equal space
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: kBottomNavigationBarHeight, // keeps height consistent
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconLocation,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.primary : AppColors.placeholder,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          isActive ? AppColors.primary : AppColors.placeholder,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
