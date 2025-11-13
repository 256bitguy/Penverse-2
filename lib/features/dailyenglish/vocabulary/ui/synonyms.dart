import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/constants.dart';
import '../vocab_state.dart'; // <-- your Synonym model

class SynonymPage extends StatelessWidget {
  final List<Synonym> synonyms;

  const SynonymPage({
    super.key,
    required this.synonyms,
  });

  @override
  Widget build(BuildContext context) {
    if (synonyms.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(
          child: Text(
            "No synonyms available",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Synonyms"),
        backgroundColor: AppColors.cardBackground, // match PracticePage tone
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: synonyms.length,
        itemBuilder: (context, index) {
          final synonym = synonyms[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // English + Hindi words
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      synonym.word,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Text(
                  synonym.meaning,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),

                const SizedBox(height: 8),

                // English explanation
                Text(
                  synonym.englishExplanation,
                  style: GoogleFonts.merriweather(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),

                // Hindi explanation
                Text(
                  synonym.hindiExplanation,
                  style: GoogleFonts.merriweather(
                    fontSize: 15,
                    color: Colors.greenAccent,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
