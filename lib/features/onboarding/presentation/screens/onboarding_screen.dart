import '../../../auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/animation_utils.dart';
import '../../../../core/utils/page_transitions.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../auth/presentation/screens/create_account_screen.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    if (_currentPage < AppConstants.onboardingItems.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onPreviousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onSkip() {
    _pageController.animateToPage(
      AppConstants.onboardingItems.length - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  void _handleDragEnd(DragEndDetails details) {
    if (details.primaryVelocity == null) return;
    if (details.primaryVelocity! > 0) {
      _onPreviousPage();
    } else if (details.primaryVelocity! < 0) {
      _onNextPage();
    }
  }

  Widget _buildSkipButton() {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 32 : 16),
        child: TextButton(
          onPressed: _onSkip,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 24 : 16,
              vertical: isDesktop ? 16 : 12,
            ),
          ),
          child: Text(
            'skip',
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      padding: EdgeInsets.all(isDesktop ? 48 : 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PageIndicator(
            currentPage: _currentPage,
            pageCount: AppConstants.onboardingItems.length,
          ),
          SizedBox(height: isDesktop ? 48 : 32),
          Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 400 : double.infinity,
            ),
            child: _currentPage == AppConstants.onboardingItems.length - 1
                ? Column(
                    children: [
                      CustomButton(
                        text: 'Create an account',
                        onPressed: () {
                          Navigator.push(
                            context,
                            FadeSlidePageRoute(
                              page: const CreateAccountScreen(),
                              direction: SlideDirection.up,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: isDesktop ? 24 : 16),
                      CustomButton(
                        text: 'Log in',
                        isSecondary: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            FadeSlidePageRoute(
                              page: const LoginScreen(),
                              direction: SlideDirection.up,
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : CustomButton(
                    text: 'Next',
                    onPressed: _onNextPage,
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildSkipButton(),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: _handleDragEnd,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemCount: AppConstants.onboardingItems.length,
                  itemBuilder: (context, index) => OnboardingContent(
                    item: AppConstants.onboardingItems[index],
                    index: index,
                    currentPage: _currentPage,
                  ),
                ),
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }
}
