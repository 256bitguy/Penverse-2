import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/constants.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    this.icon,
    this.iconLocation,
    required this.name,
    required this.isActive,
    required this.onTap,
  }) : assert(
          icon != null || iconLocation != null,
          'Either icon or iconLocation must be provided',
        );

  /// If using Flutter built-in icons
  final IconData? icon;

  /// If using custom SVG icons
  final String? iconLocation;

  final String name;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.tealAccent : AppColors.placeholder;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Decide which type of icon to render
          if (icon != null)
            Icon(
              icon,
              size: 28,
              color: color,
            )
          else
            SvgPicture.asset(
              iconLocation!,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),

          const SizedBox(height: 4),

          Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}
