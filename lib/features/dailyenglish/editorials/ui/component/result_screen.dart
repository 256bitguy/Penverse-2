import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/constants/constants.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground, // ✅ darker consistent appbar
        title: const Text(
          "Result",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ✅ Body Layout
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const Spacer(),

              // ✅ “Your Score” text
              Text(
                "Your Score",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // ✅ Big score
              Text(
                "$score / $total",
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: Colors.tealAccent,
                ),
              ),
              const SizedBox(height: 24),

              // ✅ Motivational note
              Text(
                _getMessage(score, total),
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              // ✅ Button at bottom
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[700],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Back to Article",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Optional motivational note depending on score
  String _getMessage(int score, int total) {
    final percent = (score / total) * 100;
    if (percent >= 90) return "Excellent! 🌟 You truly mastered this one!";
    if (percent >= 70) return "Great job! Keep up the learning momentum.";
    if (percent >= 50) return "Nice effort! A bit more practice will perfect it.";
    return "Don’t worry — every mistake is a step toward mastery!";
  }
}
