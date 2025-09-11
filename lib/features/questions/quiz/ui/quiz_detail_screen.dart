import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../data/quiz_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../quiz/redux/quiz_action.dart';

class QuizDetailScreen extends StatefulWidget {
  final String quizId;
  const QuizDetailScreen({super.key, required this.quizId});

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _quizStarted = false;

  @override
  void initState() {
    super.initState();
    // 🔹 Dispatch fetch action to load full quiz
    Future.microtask(() {
      final store = StoreProvider.of<AppState>(context);
      final vm = QuizViewModel.fromStore(store);
      vm.fetchQuizById(widget.quizId);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _secondsElapsed = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String get formattedTime {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuizViewModel>(
      converter: (store) => QuizViewModel.fromStore(store),
      builder: (context, vm) {
        // 🔹 Show loading
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔹 Show error if any
        if (vm.error.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text("Quiz Detail")),
            body: Center(
              child: Text(
                "⚠️ Error: ${vm.error}",
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // 🔹 Get the selected full quiz
        final quiz = vm.selectedQuiz;
        if (quiz == null || quiz.id != widget.quizId) {
          return const Scaffold(
            body: Center(child: Text("Quiz details not loaded")),
          );
        }

        // 🔹 Render description + questions
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Text(
              quiz.title ?? "Quiz Detail",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          body: PageView.builder(
            controller: _pageController,
            itemCount: quiz.questions.length + 1, // +1 for description
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // ✅ First page: Quiz description with Start button
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.deepPurple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            quiz.title ?? "Quiz Detail",
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                quiz.description ??
                                    "No description available.",
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  height: 1.6,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              _quizStarted = true;
                              _startTimer(); // start timer
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text("Start Quiz"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: GoogleFonts.lato(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // ✅ Other pages: Questions
              final question = quiz.questions[index - 1]; // shift by 1
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timer display
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.timer, color: Color.fromARGB(255, 233, 82, 95)),
                            const SizedBox(width: 6),
                            Text(
                              formattedTime,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 195, 183, 222),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Q$index. ${question.questionText}",
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 213, 210, 221),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (question.imageUrl != null)
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                question.imageUrl!,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        ...question.options.map(
                          (opt) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor:
                                    const Color.fromARGB(255, 165, 128, 231),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                final isCorrect =
                                    opt.text == question.correctAnswer;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isCorrect
                                          ? "✅ Correct!"
                                          : "❌ Wrong! Correct Answer: ${question.correctAnswer}",
                                    ),
                                    backgroundColor: isCorrect
                                        ? Colors.green
                                        : Colors.redAccent,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );

                                // Auto go to next question
                                Future.delayed(const Duration(milliseconds: 400),
                                    () {
                                  if (index < quiz.questions.length) {
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut);
                                  } else {
                                    _stopTimer(); // stop timer at end
                                    // You can navigate to result screen here
                                  }
                                });
                              },
                              child: Text(
                                opt.text,
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (index < quiz.questions.length) {
                                _pageController.nextPage(
                                  duration:
                                      const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                _stopTimer();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade600,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Next"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
