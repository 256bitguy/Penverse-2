import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/constants.dart';
 import '../vocab_state.dart';  // <-- import your Antonym model

class AntonymPage extends StatelessWidget {
  final List<Antonym> antonyms;

  const AntonymPage({
    super.key,
    required this.antonyms,
  });

  @override
  Widget build(BuildContext context) {
    if (antonyms.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No antonyms available",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Antonyms"),
        backgroundColor: AppColors.scaffoldBackground,
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: antonyms.length,
        itemBuilder: (context, index) {
          final antonym = antonyms[index];
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
                // Word and its opposite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      antonym.word,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      antonym.meaning,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Usage sentence (English)
                Text(
                  "  ${antonym.englishExplanation}",
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),

                // Usage sentence (Hindi)
                Text(
                  "  ${antonym.hindiExplanation}",
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
