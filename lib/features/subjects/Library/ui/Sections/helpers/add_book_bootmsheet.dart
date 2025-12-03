import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/core/models/book_model.dart';

class PurchasedBookDrawer extends StatefulWidget {
  final Function(Book) onBookSelected;

  const PurchasedBookDrawer({
    super.key,
    required this.onBookSelected,
  });

  @override
  State<PurchasedBookDrawer> createState() => _PurchasedBookDrawerState();
}

class _PurchasedBookDrawerState extends State<PurchasedBookDrawer> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> filteredBooks = [];

  @override
  void initState() {
    super.initState();

    // Listen to search input changes
    _searchController.addListener(() {
      final query = _searchController.text.trim().toLowerCase();

      setState(() {
        filteredBooks = allBooks
            .where((book) =>
                book.title.toLowerCase().contains(query) ||
                book.author.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  List<Book> allBooks = [];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Book>>(
      converter: (store) => store.state.purchasedBookState.results,
      onInit: (store) {
        allBooks = store.state.purchasedBookState.results;
        filteredBooks = allBooks;
      },
      builder: (context, purchasedBooks) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.88,
          initialChildSize: 0.62,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF0E0E0E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // Handle
                  Container(
                    width: 48,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Select a Book",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // SEARCH FIELD
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search books...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        prefixIcon: const Icon(Icons.search, color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Book List
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            widget.onBookSelected(book);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    book.coverImage,
                                    height: 72,
                                    width: 52,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        book.author,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.add_circle_outline,
                                    color: Colors.tealAccent),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
