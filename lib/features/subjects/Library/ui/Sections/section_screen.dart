// lib/features/sections/ui/section_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_viewmodel.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_books_actions.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_actions.dart';
import 'package:penverse/features/subjects/Library/ui/Sections/helpers/add_book_bootmsheet.dart';

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

  @override
  void initState() {
    super.initState();
    // Load books for this section on screen init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StoreProvider.of<AppState>(context)
          .dispatch(LoadBooksBySectionRequestAction(widget.sectionId));
    });
  }

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
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
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
                    content:
                        Text('Section "${widget.sectionName}" deleted (mock).'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
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

  void _openPurchasedBookDrawer(String sectionId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PurchasedBookDrawer(
        onBookSelected: (book) {
          // Dispatch add book action
          StoreProvider.of<AppState>(context).dispatch(
            AddBookToSectionAction(
              sectionId: sectionId,
              bookId: book.id,
            ),
          );
          // Reload books after adding
          StoreProvider.of<AppState>(context)
              .dispatch(LoadBooksBySectionRequestAction(sectionId));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SectionBooksViewModel>(
      converter: (store) =>
          SectionBooksViewModel.fromStore(store, widget.sectionId),
      builder: (context, vm) {
        final filteredBooks = vm.books.where((b) {
          final q = searchQuery.toLowerCase();
          return b.title.toLowerCase().contains(q) ||
              b.author.toLowerCase().contains(q);
        }).toList();

              // print(vm.books.length);
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
              // Loading state
              if (vm.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (vm.error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      'Error: ${vm.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (filteredBooks.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      "No books found.",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.08)),
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
                                        color: Colors.white70, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.transparent,
                child: ElevatedButton(
                  onPressed: () => _openPurchasedBookDrawer(widget.sectionId),
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
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.tealAccent,
                    ),
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
