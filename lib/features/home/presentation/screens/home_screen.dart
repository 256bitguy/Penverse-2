import 'package:flutter/material.dart';
// import 'package:penverse/features/home/presentation/screens/BookPreviewPage.dart';
import '../widgets/bannerCarousel.dart';
import '../widgets/SectionWidget.dart';
import '../widgets/AuthorWidget.dart';
import '../widgets/Recommentation.dart';
import '../widgets/BookListPage.dart';
import '../../../../core/constants/app_colors.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchSuggestions = [];
  final List<String> _allItems = [
    "History",
    "Banking",
    "Science",
    "Math",
    "Literature",
    "Flutter",
    "Dart",
    "Physics"
  ];

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchSuggestions = [];
      } else {
        _searchSuggestions = _allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        title: const Text("Penverse"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
        backgroundColor: AppColors.cardBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          // const BookPreviewPage(),// Navigate to new page
                          BookListPage(),
                    ),
                  );
                },
                child: AbsorbPointer(
                  // Prevents keyboard from opening
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    readOnly: true, // ensures it doesn’t open keyboard
                    decoration: InputDecoration(
                      hintText: "Search subjects, books, authors...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                    ),
                  ),
                ),
              ),
            ),

            // // Search Suggestions
            // if (_searchSuggestions.isNotEmpty)
            //   ListView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: _searchSuggestions.length,
            //     itemBuilder: (_, index) => ListTile(
            //       title: Text(_searchSuggestions[index]),
            //       onTap: () {
            //         _searchController.text = _searchSuggestions[index];
            //         setState(() {
            //           _searchSuggestions = [];
            //         });
            //       },
            //     ),
            //   ),

            // Banner Image
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: BannerCarousel(),
            ),

            // Books Section

            SectionWidgets(
              title: "Popular Books",
              items: List.generate(
                5,
                (index) {
                  // List of different book image URLs
                  final bookImages = [
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761830977/uploads/rn2ng9wirsrhuhegspt1.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761831276/uploads/ktf9uyrn3apcaqhex5xd.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761830977/uploads/rn2ng9wirsrhuhegspt1.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761831276/uploads/ktf9uyrn3apcaqhex5xd.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761830977/uploads/rn2ng9wirsrhuhegspt1.png",
                  ];

                  return {
                    "image": bookImages[index],
                    "title": "Book $index",
                    "author": "Author $index",
                    "type": ["CBSE", "UPSC", "Banking"][index % 3],
                    "readers": "${1 + index * 0.5}k"
                  };
                },
              ),
            ),

          const  FictionRecommendationWidget(
  title: "Recommended Fiction Books",
  books: [
    {
      "image": "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832564/uploads/lnys2wqukbw04mrkw0kr.png",
      "title": "The Whispering Shadows",
      "author": "Emily Hart",
      "readers": "8.5k",
      "price": "299",
    },
    {
      "image": "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832763/uploads/rvqbrnqcg6lbrzfpaqqz.png",
      "title": "Dreams of Tomorrow",
      "author": "Ravi Kumar",
      "readers": "5.3k",
      "price": "249",
    },
    {
      "image": "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832564/uploads/lnys2wqukbw04mrkw0kr.png",
      "title": "Beneath the Crimson Sky",
      "author": "Lara White",
      "readers": "10.1k",
      "price": "399",
    },
    {
      "image": "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832763/uploads/rvqbrnqcg6lbrzfpaqqz.png",
      "title": "City of Secrets",
      "author": "Arjun Mehta",
      "readers": "7.2k",
      "price": "279",
    },
    {
      "image": "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832564/uploads/lnys2wqukbw04mrkw0kr.png",
      "title": "Winds of Destiny",
      "author": "Sophia Khan",
      "readers": "6.8k",
      "price": "349",
    },
  ],
  
)
,
            AuthorSectionWidget(
              title: "Popular Authors",
              authors: List.generate(
                5,
                (index) => {
                  "image": [
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832057/uploads/gvrpygp0qvghnceuux6e.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832124/uploads/eh3a64otyc7cvfxtzgn7.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832057/uploads/gvrpygp0qvghnceuux6e.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832124/uploads/eh3a64otyc7cvfxtzgn7.png",
                    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832057/uploads/gvrpygp0qvghnceuux6e.png",
                  ][index],
                  "name": ["Dr. Tanu Jain", "Sudarshan Gujjar", "Dr. Tanu Jain", "Arvind Kumar", "Dr. Tanu Jain"][index],
                  "genre": [
                    "UPSC",
                    "Geography",
                    "Science",
                    "Philosophy",
                    "Poetry"
                  ][index],
                  "books": "${(index + 1) * 3}",
                },
              ),
             
            ),
          ],
        ),
      ),
    );
  }
}

/// Section widget for horizontal card lists
