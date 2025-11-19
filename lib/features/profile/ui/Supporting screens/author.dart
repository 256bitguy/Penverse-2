import 'package:flutter/material.dart';
import 'package:penverse/core/constants/app_colors.dart';

class AuthorBooksWidget extends StatelessWidget {
  final List<Map<String, String>> books;

  const AuthorBooksWidget({
    super.key,
    required this.books,
  });
  
  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          "No books uploaded yet.",
          style: TextStyle(fontSize: 15, color: Colors.black54),
        ),
      );
    }

    return Column(
      children: books.map((book) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // BOOK COVER
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book["cover"] ?? "",
                  width: 55,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    width: 55,
                    height: 75,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported, size: 22),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 55,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 15),

              // BOOK TITLE
              Expanded(
                child: Text(
                  book["title"] ?? "Untitled Book",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
