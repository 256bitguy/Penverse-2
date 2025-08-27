class AppConstants {
  static const String appName = 'Penverse';
  
  // Onboarding Screen Constants
  static const List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'PENVERSE ',
      description: 'Explore daily vocab from the editorials like The Hindu, The Indian times ',
      imagePath: 'assets/images/onboarding1.png',
    ),
    OnboardingItem(
      title: 'Grammer and Translation',
      description: 'Learn Grammer with ease and practise in a well mannered way',
      imagePath: 'assets/images/onboarding2.png',
    ),
    OnboardingItem(
      title: 'Access to quiz and vocab',
      description: 'Practise questions by putting them together',
      imagePath: 'assets/images/onboarding3.png',
    ),
  ];
}

class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}