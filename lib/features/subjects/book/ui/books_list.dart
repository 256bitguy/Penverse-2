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
              child: Text('Error: ${vm.error}', style: const TextStyle(color: Colors.red)),
            ),
          );
        }

        if (vm.books.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('No books found', style: TextStyle(color: Colors.white70)),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Books",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.books.length,
            itemBuilder: (context, index) {
              final book = vm.books[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3)),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: book.coverImage.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            book.coverImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.blue.shade200,
                          child: const Icon(Icons.book, size: 32, color: Colors.white),
                        ),
                  title: Text(
                    book.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                  ),
                  subtitle: Text(
                    'Author: ${book.author} | Chapters: ${book.totalChapters}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white54),
                  onTap: () {
                    if (book.totalChapters != 0) {
                      vm.loadChaptersByBook(book.id);
                      Navigator.pushNamed(context, '/chapters');
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
