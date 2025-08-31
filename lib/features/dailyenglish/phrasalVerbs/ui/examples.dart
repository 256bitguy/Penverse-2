import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/constants.dart';
import '../phrasal_verb_state.dart'; // <-- import your PhrasalVerbExample model

class PhrasalVerbExamplePage extends StatelessWidget {
  final List<PhrasalVerbExample> examples;

  const PhrasalVerbExamplePage({
    super.key,
    required this.examples,
  });

  @override
  Widget build(BuildContext context) {
    if (examples.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No examples available",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Examples"),
        backgroundColor: AppColors.scaffoldBackground,
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: examples.length,
        itemBuilder: (context, index) {
          final example = examples[index];
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
                // English sentence
                Text(
                  example.sentence,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Situation (context of the example)
                Text(
                  "Situation: ${example.situation}",
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 6),

                // Hindi sentence
                Text(
                  example.hindiSentence,
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
