import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/constants.dart';
import '../vocab_state.dart'; // <-- import your Antonym model

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
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(
          child: Text(
            "No antonyms available",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Antonyms"),
        backgroundColor: Colors.black,
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
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Antonym word and meaning
                Text(
                  antonym.word,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  antonym.meaning,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 10),

                // English Explanation
                Text(
                  antonym.englishExplanation,
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),

                // Hindi Explanation
                Text(
                  antonym.hindiExplanation,
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
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
