import 'package:flutter/material.dart';
import 'package:penverse/core/constants/app_colors.dart';
import 'package:penverse/core/models/book_model.dart';
import 'package:penverse/features/home/presentation/screens/BookPreviewPage.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
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
              builder: (context) => BookPreviewPage(book: book),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BOOK IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.coverImage ?? "",
                  height: 170,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // BOOK DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      book.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // AUTHOR
                    Text(
                      "By ${book.author ?? ''}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // DESCRIPTION
                    Text(
                      book.description ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: Color.fromARGB(221, 213, 206, 206),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // TYPE + LANGUAGE
                    Row(
                      children: [
                        Text(
                          book.type ?? "N/A",
                          style: const TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            book.language ?? "N/A",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // RATING
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          "${book.rating ?? "4.5"}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // PRICE
                    Row(
                      children: [
                        Text(
                          "₹ ${book.price ?? ""}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "₹ ${book.discountPrice ?? ""}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
