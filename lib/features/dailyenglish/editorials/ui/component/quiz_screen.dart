import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/constants/app_colors.dart';
import '../component/result_screen.dart';
import '../../editorial_state.dart';

class QuizScreen extends StatefulWidget {
  final EditorialItem item;

  const QuizScreen({super.key, required this.item});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  String? selectedOption;
  bool answered = false;

  void _selectOption(String selected) {
    if (answered) return; // prevent reselecting
    setState(() {
      selectedOption = selected;
      answered = true;
    });

    final question = widget.item.questions[currentIndex];
    if (selected == question.correctAnswer) {
      score++;
    }
  }

  void _nextQuestion() {
    if (currentIndex < widget.item.questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null;
        answered = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ResultScreen(score: score, total: widget.item.questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.item.questions[currentIndex];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        title: const Text("Quiz", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Question number + text
              Text(
                "Question ${currentIndex + 1} of ${widget.item.questions.length}",
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                question.statement,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 28),

              // ✅ Options
              ...question.options.map((opt) {
                final isSelected = selectedOption == opt.statement;
                final isCorrect =
                    opt.statement == question.correctAnswer && answered;

                Color bgColor = AppColors.cardBackground;
                if (answered) {
                  if (isCorrect) bgColor = Colors.green.withOpacity(0.7);
                  else if (isSelected) bgColor = Colors.red.withOpacity(0.7);
                } else if (isSelected) {
                  bgColor = Colors.teal.withOpacity(0.7);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _selectOption(opt.statement),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        child: Text(
                          opt.statement,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const Spacer(),

              // ✅ Next Button
              if (answered)
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
                    onPressed: _nextQuestion,
                    child: Text(
                      currentIndex < widget.item.questions.length - 1
                          ? "Next"
                          : "See Result",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
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
}
