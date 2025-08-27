import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    
    final double dotHeight = isDesktop ? 6 : 4;
    final double activeDotWidth = isDesktop ? 40 : 32;
    final double inactiveDotWidth = isDesktop ? 20 : 16;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: isDesktop ? 6 : 4,
          ),
          height: dotHeight,
          width: currentPage == index ? activeDotWidth : inactiveDotWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(
                  currentPage == index ? 1.0 : 0.5,
                ),
            borderRadius: BorderRadius.circular(dotHeight / 2),
          ),
        ),
      ),
    );
  }
}