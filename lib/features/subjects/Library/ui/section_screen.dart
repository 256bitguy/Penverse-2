// lib/features/sections/ui/section_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/store/app_state.dart';
import '../../book/data/book_view_model.dart';

class SectionScreen extends StatefulWidget {
  final String sectionName;
  final String sectionId;

  const SectionScreen({
    super.key,
    required this.sectionName,
    required this.sectionId,
  });

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  String searchQuery = "";

  // Dummy available books shown in bottom drawer
  final List<Map<String, String>> availableBooks = [
    {
      "id": "b_at_habits",
      "title": "Atomic Habits",
      "author": "James Clear",
      "cover":
          "https://m.media-amazon.com/images/I/81-QB7nDh4L._AC_UY327_FMwebp_QL65_.jpg"
    },
    {
      "id": "b_alchemist",
      "title": "The Alchemist",
      "author": "Paulo Coelho",
      "cover":
          "https://m.media-amazon.com/images/I/71aFt4+OTOL._AC_UY327_FMwebp_QL65_.jpg"
    },
    {
      "id": "b_psych_money",
      "title": "The Psychology of Money",
      "author": "Morgan Housel",
      "cover":
          "https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg"
    },
    {
      "id": "b_deep_work",
      "title": "Deep Work",
      "author": "Cal Newport",
      "cover":
          "https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg"
    },
    {
      "id": "b_rpdd",
      "title": "Rich Dad Poor Dad",
      "author": "Robert Kiyosaki",
      "cover":
          "https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg"
    },
    // add more if desired
  ];

  // Books added to this section locally (will also be shown in UI)
  final List<Map<String, String>> addedBooks = [];

  // ====================================================
  // 🚨 DELETE CONFIRMATION MODAL
  // ====================================================
  void _confirmDeleteSection() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Text(
            "Delete \"${widget.sectionName}\"?",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to delete this section? This action cannot be undone.",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.tealAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: call delete API / dispatch redux action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Section "${widget.sectionName}" deleted (mock).'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                // Optionally pop the screen after deletion:
                // Navigator.pop(context);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  // ====================================================
  // Open bottom drawer to pick a book to add
  // ====================================================
  void _openAddBookDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0E0E0E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
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
                  // Drag handle
                  Container(
                    width: 48,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Add Book to \"${widget.sectionName}\"",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Optional search within drawer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search available books...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: const Icon(Icons.search, color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.03),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                      onChanged: (q) {
                        // Optional: implement filtering of availableBooks
                        // For simplicity not implemented here
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Scrollable list of available books
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: availableBooks.length,
                      padding: const EdgeInsets.only(bottom: 24),
                      itemBuilder: (context, index) {
                        final book = availableBooks[index];
                        final alreadyAdded = addedBooks.any((b) => b["id"] == book["id"]);

                        return GestureDetector(
                          onTap: () {
                            if (!alreadyAdded) {
                              setState(() {
                                // add to top of addedBooks
                                addedBooks.insert(0, book);
                              });

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added "${book["title"]}" to section.'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              // if already added, just show message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('"${book["title"]}" is already added.'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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
                                    book["cover"] ?? '',
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
                                        book["title"] ?? '',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        book["author"] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  alreadyAdded ? Icons.check_circle : Icons.add_circle_outline,
                                  color: alreadyAdded ? Colors.greenAccent : Colors.tealAccent,
                                ),
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

  // ====================================================
  // MAIN UI
  // ====================================================
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookViewModel>(
      converter: (store) => BookViewModel.fromStore(store),
      builder: (context, vm) {
        // Loading screen
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Error screen
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

        // Filter backend books based on search
        // final backendBooks = vm.books.where((book) {
        //   final q = searchQuery.toLowerCase();
        //   return   
        //       book.title.toLowerCase().contains(q) ||
        //       book.author.toLowerCase().contains(q)   ;
        // }).toList();

        // Filter locally added books
        final filteredAddedBooks = addedBooks.where((b) {
          final q = searchQuery.toLowerCase();
          return b["title"]!.toLowerCase().contains(q) ||
              b["author"]!.toLowerCase().contains(q);
        }).toList();

        return Scaffold(
          backgroundColor: const Color(0xFF0E0E0E),
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 4,
            shadowColor: Colors.white10,
            title: Text(
              widget.sectionName,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: _confirmDeleteSection,
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 12),
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: "Search books...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.search, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.03),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Locally added books (if any)
              if (filteredAddedBooks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Added to this section",
                      style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredAddedBooks.length,
                  itemBuilder: (context, index) {
                    final book = filteredAddedBooks[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              book["cover"] ?? '',
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
                                  book["title"] ?? '',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book["author"] ?? '',
                                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Remove from addedBooks
                              setState(() {
                                addedBooks.removeWhere((b) => b["id"] == book["id"]);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Removed "${book["title"]}"')),
                              );
                            },
                            icon: const Icon(Icons.delete_outline, color: Colors.white54),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 6),
              ],

              // Main backend book list
              // Expanded(
              //   child: backendBooks.isEmpty
              //       ? Center(
              //           child: Text(
              //             'No books in this section',
              //             style: GoogleFonts.poppins(color: Colors.white54, fontSize: 16),
              //           ),
              //         )
              //       : ListView.builder(
              //           padding: const EdgeInsets.all(16),
              //           itemCount: backendBooks.length,
              //           itemBuilder: (context, index) {
              //             final book = backendBooks[index];
              //             final double progress = 10; // mock
              //             final bool completed = progress >= 100;

              //             return Container(
              //               margin: const EdgeInsets.symmetric(vertical: 10),
              //               padding: const EdgeInsets.all(14),
              //               decoration: BoxDecoration(
              //                 color: Colors.white.withOpacity(0.08),
              //                 borderRadius: BorderRadius.circular(16),
              //                 border: Border.all(color: Colors.white.withOpacity(0.2)),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.3),
              //                     blurRadius: 8,
              //                     offset: const Offset(0, 3),
              //                   ),
              //                 ],
              //               ),
              //               child: Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   ClipRRect(
              //                     borderRadius: BorderRadius.circular(8),
              //                     child: Image.network(
              //                       book.coverImage.isNotEmpty
              //                           ? book.coverImage
              //                           : 'https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg',
              //                       height: 160,
              //                       width: 115,
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                   const SizedBox(width: 14),
              //                   Expanded(
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           book.title,
              //                           maxLines: 2,
              //                           overflow: TextOverflow.ellipsis,
              //                           style: const TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.w600,
              //                             color: Colors.white,
              //                           ),
              //                         ),
              //                         const SizedBox(height: 4),
              //                         Text(
              //                           book.author,
              //                           style: const TextStyle(
              //                             color: Colors.grey,
              //                             fontSize: 13,
              //                           ),
              //                         ),
              //                         const SizedBox(height: 10),
              //                         Text(
              //                           book.description.isNotEmpty ? book.description : "No description available.",
              //                           maxLines: 2,
              //                           overflow: TextOverflow.ellipsis,
              //                           style: const TextStyle(
              //                             fontSize: 12,
              //                             color: Color.fromARGB(221, 213, 206, 206),
              //                           ),
              //                         ),
              //                         const SizedBox(height: 10),

              //                         LinearProgressIndicator(
              //                           value: progress / 100,
              //                           minHeight: 6,
              //                           borderRadius: BorderRadius.circular(10),
              //                           backgroundColor: Colors.white12,
              //                           color: completed ? Colors.greenAccent : Colors.tealAccent.withOpacity(0.3),
              //                         ),
              //                         const SizedBox(height: 6),

              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text(
              //                               completed ? "Completed" : "Progress: ${progress.toStringAsFixed(0)}%",
              //                               style: TextStyle(
              //                                 fontSize: 12,
              //                                 color: completed ? Colors.greenAccent : Colors.white70,
              //                               ),
              //                             ),
              //                             Text(
              //                               "${book.totalChapters} Chapters",
              //                               style: const TextStyle(fontSize: 12, color: Colors.white54),
              //                             ),
              //                           ],
              //                         ),

              //                         const SizedBox(height: 12),

              //                         ElevatedButton(
              //                           onPressed: () {
              //                             vm.loadChaptersByBook(book.id);
              //                             Navigator.pushNamed(context, '/chapters');
              //                           },
              //                           style: ElevatedButton.styleFrom(
              //                             backgroundColor: completed ? Colors.greenAccent.withOpacity(0.9) : Colors.tealAccent.withOpacity(0.3),
              //                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              //                           ),
              //                           child: Text(
              //                             completed ? "Read Again" : "Continue Reading",
              //                             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              // ),

              // Full-width Add Book button at bottom
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.transparent,
                child: ElevatedButton(
                  onPressed: _openAddBookDrawer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent.withOpacity(0.18),
                    foregroundColor: Colors.tealAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Colors.tealAccent),
                    ),
                  ),
                  child: Text(
                    "Add Book +",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.tealAccent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
