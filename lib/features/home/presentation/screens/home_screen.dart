import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: const Text(
          "Penverse",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // TODO: navigate to profile
            },
          ),
        ],
      ),

      
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            SectionWidget(
              title: "Popular Subjects",
              items: [
                {"image": "assets/images/onboarding1.png", "text": "Math"},
                {"image": "assets/images/onboarding2.png", "text": "Science"},
                {"image": "assets/images/onboarding3.png", "text": "History"},
                {"image": "assets/images/onboarding1.png", "text": "English"},
              ],
            ),
            SectionWidget(
              title: "Recommended",
              items: [
                {"image": "assets/images/onboarding1.png", "text": "Physics"},
                {"image": "assets/images/onboarding2.png", "text": "Chemistry"},
                {"image": "assets/images/onboarding1.png", "text": "Biology"},
                {"image": "assets/images/onboarding3.png", "text": "Geography"},
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable widget for sections with a title + horizontal scroll list
class SectionWidget extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;

  const SectionWidget({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width / 2; // 1/4 width
    final itemHeight = screenSize.height / 4; // 1/6 height

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: itemHeight + 45, // image + text space
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                final item = items[index];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        item["image"]!,
                        width: itemWidth,
                        height: itemHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item["text"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22, // larger text
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
