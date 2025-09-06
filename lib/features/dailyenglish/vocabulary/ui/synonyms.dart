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
        body: Center(
          child: Text(
            "No synonyms available",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Synonyms"),
        backgroundColor: AppColors.scaffoldBackground,
        centerTitle: true,
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
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24, width: 1),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                // English explanation
                Text(
                  "  ${synonym.englishExplanation}",
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),

                // Hindi explanation
                Text(
                  "  ${synonym.hindiExplanation}",
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    color: Colors.greenAccent,
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
