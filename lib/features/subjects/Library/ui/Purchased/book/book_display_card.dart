import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/models/book_model.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/chapter/data/chapter_view_model.dart';
import 'package:penverse/features/subjects/chapter/ui/chapters_list.dart';

class PurchasedBookCard extends StatelessWidget {
  final Book book;

  const PurchasedBookCard({
    super.key,
    required this.book,
  });

  String _formattedDate(String date) {
    final dt = DateTime.tryParse(date);
    if (dt == null) return "Unknown Date";

    return "${dt.day}-${dt.month}-${dt.year}";
  }

  String _readingButtonLabel(double progress) {
    if (progress <= 0) return "Start Reading";
    if (progress > 0 && progress < 90) return "Continue Reading";
    return "Let's Complete";
  }

  @override
  Widget build(BuildContext context) {
    final cover = book.coverImage;
    final title = book.title;
    final author = book.author;
    final int chapters = book.totalChapters ?? 0;
    final language = book.language;

    // You may calculate progress from backend; for now static = 0%
    final double progress = 90;
    //  book.progress != null
    //     ? (book.progress as num).toDouble()
    //     : 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff1e1e1e),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Cover Image ---
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "${book.coverImage}",
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// --- Details Section ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "${book.title}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 4),

                // Author
                Text(
                  "By $author",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 6),

                // Total Chapters + Language
                Text(
                  "Chapters: $chapters | Language: ${language.toString().toUpperCase()}",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 6),

                // Purchased Date
                Text(
                  "Purchased on: ${_formattedDate("${book.purchasedAt}")}",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.tealAccent,
                  ),
                ),

                const SizedBox(height: 10),

                // Progress Bar
                LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.white12,
                  color: Colors.tealAccent,
                  minHeight: 5,
                ),

                const SizedBox(height: 10),

                /// --- Read Button ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: chapters == 0
                        ? null
                        : () {
                            // 1️⃣ Access the Redux store
                            final store = StoreProvider.of<AppState>(context);

                            // 2️⃣ Create ViewModel
                            final chaptersVM =
                                ChaptersViewModel.fromStore(store);

                            // 3️⃣ Call the method before navigation
                            chaptersVM.loadChaptersByBook(book.id);

                            // 4️⃣ Navigate to ChapterListScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ChapterListScreen(), // pass bookId if needed
                              ),
                            );
                          },

// 🔥 disable if 0 chapters

                    style: ElevatedButton.styleFrom(
                      backgroundColor: chapters == 0
                          ? Colors.grey // disabled color
                          : Colors.tealAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    child: Text(
                      chapters == 0
                          ? "No Chapters Available"
                          : _readingButtonLabel(progress),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
