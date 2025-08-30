import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../book/ui/books_list.dart';

class SubjectsScreen extends StatelessWidget {
  final int id;
  const SubjectsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {"title": "English", "count": 24, "image": Icons.calculate},
      {"title": "Science", "count": 18, "image": Icons.science},
      {"title": "History", "count": 12, "image": Icons.history_edu},
      {"title": "Literature", "count": 9, "image": Icons.menu_book},
      {"title": "Economics", "count": 19, "image": Icons.history_edu},
      {"title": "Polity", "count": 92, "image": Icons.science},
      {"title": "CSAT", "count":45 , "image": Icons.menu_book},
    ];

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(alpha: 0.1), // semi-transparent for dark mode
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3), // subtle border
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4), // shadow direction: bottom
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withValues(alpha: 0.2),
                    Colors.purple.withValues(alpha: 0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search subjects...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.grey),
                    onPressed: () {
                      // TODO: filter action
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 📚 Subject List
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                    child: Card(
                      elevation: 3,
                      color: const Color(0xFF6472BB), // shadow depth
                      shadowColor: Colors.black.withValues(alpha: 0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // bigger radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          leading: CircleAvatar(
                            radius: 34, // bigger avatar
                            backgroundColor: Colors.blue.shade200,
                            child: Icon(
                              subject["image"] as IconData,
                              color: const Color(0xFF8B94C4),
                              size: 32, // bigger icon
                            ),
                          ),
                          title: Text(
                            subject["title"].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB2B9DB),
                              fontSize: 18, // increased font size
                            ),
                          ),
                          subtitle: Text(
                            "${subject["count"]} ",
                            style: const TextStyle(
                              color: Color(0xFFE6E8F1),
                              fontSize: 14,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 18, color: Colors.grey),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>  BooksListScreen(id: id+1),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
