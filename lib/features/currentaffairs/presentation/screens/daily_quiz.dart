import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
class DailyQuizScreen extends StatefulWidget {
  const DailyQuizScreen({super.key});

  @override
  State<DailyQuizScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<DailyQuizScreen> {
  int currentIndex = 0;

  final List<String> images = [
    "assets/images/onboarding1.png",
    "assets/images/onboarding2.png",
    "assets/images/onboarding3.png",
  ];

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
 final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width ;  
    final itemHeight = screenSize.height / 2;  
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text(
          "Penverse",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: search action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date + Index
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "2-August-2025",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  "${currentIndex + 1}/${images.length}",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: Image.network(
                images[currentIndex],
                height: itemHeight ,
                width: itemWidth,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Tag Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Tag",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Rectangular Button (route)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OtherPage(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "The other side of the news",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Next Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentIndex = (currentIndex + 1) % images.length;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D0D25),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  
                ),
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy route page
class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1E23),
        title: const Text("Other Page"),
      ),
      body: const Center(
        child: Text(
          "The other side of the news content...",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
