import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'animated_content.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;
  final int index;
  final int currentPage;

  const OnboardingContent({
    super.key,
    required this.item,
    required this.index,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isForward = index >= currentPage;

    if (isDesktop) {
      return Row(
        children: [
          Expanded(
            child: AnimatedContent(
              key: ValueKey('image-$index'),
              isForward: isForward,
              child: _buildImage(context),
            ),
          ),
          Expanded(
            child: AnimatedContent(
              key: ValueKey('content-$index'),
              isForward: !isForward,
              child: _buildContent(context),
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContent(
          key: ValueKey('image-$index'),
          isForward: isForward,
          child: _buildImage(context),
        ),
        AnimatedContent(
          key: ValueKey('content-$index'),
          isForward: !isForward,
          child: _buildContent(context),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    
    double imageHeight;
    if (isDesktop) {
      imageHeight = screenHeight * 0.5;
    } else if (isTablet) {
      imageHeight = screenHeight * 0.35;
    } else {
      imageHeight = screenHeight * 0.3;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: isDesktop ? 0 : 16,
      ),
      child: Image.asset(
        item.imagePath,
        height: imageHeight,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: isDesktop ? 48 : 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: isDesktop ? 40 : (isTablet ? 36 : 32),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 500 : 400,
            ),
            child: Text(
              item.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isDesktop ? 18 : 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}