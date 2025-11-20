import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PurchasedWidget extends StatelessWidget {
  const PurchasedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final purchasedBooks = [
      {
        "image":
            "https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg",
        "title": "The Psychology of Money",
        "author": "Morgan Housel",
        "rating": 4.5,
        "purchasedOn": "12 Jan 2025",
      },
      {
        "image":
            "https://m.media-amazon.com/images/I/71aFt4+OTOL._AC_UY327_FMwebp_QL65_.jpg",
        "title": "The Alchemist",
        "author": "Paulo Coelho",
        "rating": 4.7,
        "purchasedOn": "08 Jan 2025",
      },
      {
        "image":
            "https://m.media-amazon.com/images/I/81-QB7nDh4L._AC_UY327_FMwebp_QL65_.jpg",
        "title": "Atomic Habits",
        "author": "James Clear",
        "rating": 4.8,
        "purchasedOn": "02 Jan 2025",
      },
    ];

    return ListView.builder(
      itemCount: purchasedBooks.length,
      padding: const EdgeInsets.all(2),
      itemBuilder: (context, index) {
        final book = purchasedBooks[index];

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
              // 👉 Open Book Preview Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Center(
                    child: Text(
                      "Book Preview Page Placeholder",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              );
            },
            child: Container(
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

                  // 📚 Book Details
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
                            color: Color.fromARGB(221, 225, 219, 219),
                          ),
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
                          "This is one of your purchased books. You can start reading anytime.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: Color.fromARGB(221, 213, 206, 206),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 🗓 Purchased Date
                        Text(
                          "Purchased on: ${book["purchasedOn"]}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 142, 186, 255),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 6),

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
          ),
        );
      },
    );
  }
}
