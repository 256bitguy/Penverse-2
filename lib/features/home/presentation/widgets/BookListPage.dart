import 'package:flutter/material.dart';
import '../screens/BookPreviewPage.dart';
import '../../../../core/constants/app_colors.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      {
        "image":
            "https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg",
        "title": "The Psychology of Money",
        "author": "Morgan Housel",
        "rating": 4.5,
        "price": "₹399"
      },
      {
        "image":
            "https://m.media-amazon.com/images/I/71aFt4+OTOL._AC_UY327_FMwebp_QL65_.jpg",
        "title": "The Alchemist",
        "author": "Paulo Coelho",
        "rating": 4.7,
        "price": "₹299"
      },
      {
        "image":
            "https://m.media-amazon.com/images/I/81-QB7nDh4L._AC_UY327_FMwebp_QL65_.jpg",
        "title": "Atomic Habits",
        "author": "James Clear",
        "rating": 4.8,
        "price": "₹449"
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(31, 232, 224, 224),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black54),
                hintText: 'Search Books, Authors, Subjects...',
                hintStyle: TextStyle(color: Color.fromARGB(137, 237, 233, 233)),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: books.length,
        padding: const EdgeInsets.all(2),
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 51, 51, 79),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const BookPreviewPage(), // Pass book data
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 📘 Book Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "${book["image"]}",
                          height: 180,
                          width: 130,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // 📝 Book Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${book["title"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                  color: Color.fromARGB(221, 225, 219, 219)),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${book["author"]}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "This Book is designed for the readers who want to improve their financial knowledge and make better money decisions. And also those who are interested in understanding the psychological aspects of money management....",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                  color: Color.fromARGB(221, 213, 206, 206)),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${book["price"]}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(221, 222, 217, 217),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "This book is available for purchase.",
                              style: TextStyle(
                                color:  Color.fromARGB(255, 193, 199, 193),
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              "Readers: 1,25,000+",
                              style: TextStyle(
                                color: Color.fromARGB(255, 56, 90, 142),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
