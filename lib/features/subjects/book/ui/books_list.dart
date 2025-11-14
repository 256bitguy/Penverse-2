// lib/features/book/ui/books_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../data/book_view_model.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookViewModel>(
      converter: (store) => BookViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.error != null) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${vm.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (vm.books.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                'No books in your library yet',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF0E0E0E),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "My Library",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.books.length,
            itemBuilder: (context, index) {
              final book = vm.books[index];

              // You can later fetch this from backend UserLibrary schema
              final double progress = 10; // %
              final bool completed = progress >= 100;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📘 Book Cover
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.coverImage.isNotEmpty
                            ? book.coverImage
                            : 'https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg',
                        height: 160,
                        width: 115,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // 🧾 Book Info + Progress
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book.author,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            book.description.isNotEmpty
                                ? book.description
                                : "No description available.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(221, 213, 206, 206),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // 📖 Progress Bar
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LinearProgressIndicator(
                                value: progress / 100,
                                minHeight: 6,
                                borderRadius: BorderRadius.circular(10),
                                backgroundColor: Colors.white12,
                                color: completed
                                    ? Colors.greenAccent
                                    : Colors.tealAccent.withOpacity(0.3),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    completed
                                        ? "Completed"
                                        : "Progress: ${progress.toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: completed
                                          ? Colors.greenAccent
                                          : Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    "${book.totalChapters} Chapters",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // 📘 Action Button
                          ElevatedButton(
                            onPressed: () {
                              vm.loadChaptersByBook(book.id);
                              Navigator.pushNamed(context, '/chapters');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: completed
                                  ? Colors.greenAccent.withOpacity(0.9)
                                  : Colors.tealAccent.withOpacity(0.3),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              completed ? "Read Again" : "Continue Reading",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
