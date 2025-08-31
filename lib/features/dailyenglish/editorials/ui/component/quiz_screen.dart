import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _answerQuestion(String selected) {
    final question = widget.item.questions[currentIndex];
    if (selected == question.correctAnswer) {
      score++;
    }

    if (currentIndex < widget.item.questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score, total: widget.item.questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.item.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${currentIndex + 1}: ${question.statement}",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            ...question.options.map((opt) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  onPressed: () => _answerQuestion(opt.statement),
                  child: Text(
                    opt.statement,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
