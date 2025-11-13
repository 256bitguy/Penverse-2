import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/constants/app_colors.dart';
import 'package:penverse/features/dailyenglish/vocabulary/vocab_state.dart'; 
// adjust import to your actual VocabItem location

class SynAntQuizScreen extends StatefulWidget {
  final VocabItem vocab;

  const SynAntQuizScreen({super.key, required this.vocab});

  @override
  State<SynAntQuizScreen> createState() => _SynAntQuizScreenState();
}

class _SynAntQuizScreenState extends State<SynAntQuizScreen> {
  bool showResult = false;
  bool isCorrect = false;
  String selectedOption = "";

  late bool isSynonymQuestion;
  late String question;
  late String correctAnswer;
  late List<String> options;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final vocab = widget.vocab;
    final random = Random();

    // Extract lists from vocab
    final synList = vocab.synonyms.map((s) => s.word).toList();
    final antList = vocab.antonyms.map((a) => a.word).toList();

    // Randomly decide question type (if both available)
    if (synList.isEmpty && antList.isEmpty) {
      question = "No synonym/antonym data found for '${vocab.word}'.";
      options = [];
      correctAnswer = "";
      return;
    }

    if (synList.isEmpty) {
      isSynonymQuestion = false;
    } else if (antList.isEmpty) {
      isSynonymQuestion = true;
    } else {
      isSynonymQuestion = random.nextBool();
    }

    // Prepare question & options
    if (isSynonymQuestion) {
      question = "Select the synonym of '${vocab.word}'";

      // pick 1 correct from synonyms
      correctAnswer = synList[random.nextInt(synList.length)];

      // pick 3 from antonyms
      final distractors = _pickRandomItems(antList, 3);

      options = [correctAnswer, ...distractors];
    } else {
      question = "Select the antonym of '${vocab.word}'";

      // pick 1 correct from antonyms
      correctAnswer = antList[random.nextInt(antList.length)];

      // pick 3 from synonyms
      final distractors = _pickRandomItems(synList, 3);

      options = [correctAnswer, ...distractors];
    }

    // Fill with placeholders if any list smaller than 3
    while (options.length < 4) {
      options.add("Option ${options.length + 1}");
    }

    options.shuffle();
  }

  List<String> _pickRandomItems(List<String> list, int count) {
    final random = Random();
    final tempList = List<String>.from(list);
    tempList.shuffle(random);
    if (tempList.length <= count) return tempList;
    return tempList.sublist(0, count);
  }

  void _checkAnswer(String choice) {
    setState(() {
      selectedOption = choice;
      isCorrect = (choice == correctAnswer);
      showResult = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      showResult = false;
      selectedOption = "";
      isCorrect = false;
      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          "Synonyms & Antonyms Quiz",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Options
            ...options.map((opt) {
              final isSelected = selectedOption == opt;
              final color = !showResult
                  ? AppColors.cardBackground
                  : (opt == correctAnswer
                      ? Colors.green.withOpacity(0.7)
                      : isSelected
                          ? Colors.red.withOpacity(0.7)
                          : AppColors.cardBackground);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: showResult ? null : () => _checkAnswer(opt),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      child: Text(
                        opt,
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

            // Result + Next Button
            if (showResult)
              Center(
                child: Column(
                  children: [
                    Text(
                      isCorrect ? "✅ Correct!" : "❌ Wrong!",
                      style: GoogleFonts.poppins(
                        color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Answer: $correctAnswer",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent[700],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _nextQuestion,
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
