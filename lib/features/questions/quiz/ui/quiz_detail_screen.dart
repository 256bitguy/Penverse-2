import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../data/quiz_view_model.dart';
import '../../quiz/redux/quiz_action.dart';

class QuizDetailScreen extends StatefulWidget {
  final String quizId;
  const QuizDetailScreen({super.key, required this.quizId});

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
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
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuizViewModel>(
      converter: (store) => QuizViewModel.fromStore(store),
      builder: (context, vm) {
        // 🔹 1️⃣ Show loading
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔹 2️⃣ Show error if any
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

        // 🔹 3️⃣ Get the selected full quiz
        final quiz = vm.selectedQuiz;
        if (quiz == null || quiz.id != widget.quizId) {
          return const Scaffold(
            body: Center(child: Text("Quiz details not loaded")),
          );
        }

        // 🔹 4️⃣ Render the questions
        return Scaffold(
          appBar: AppBar(title: Text(quiz.title ?? "Quiz Detail")),
          body: PageView.builder(
            itemCount: quiz.questions.length,
            itemBuilder: (context, index) {
              final question = quiz.questions[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Q${index + 1}. ${question.questionText}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        if (question.imageUrl != null)
                          Center(
                            child: Image.network(
                              question.imageUrl!,
                              height: 120,
                            ),
                          ),
                        const SizedBox(height: 20),
                        ...question.options.map(
                          (opt) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ElevatedButton(
                              onPressed: () {
                                final isCorrect =
                                    opt.text == question.correctAnswer;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isCorrect
                                          ? "✅ Correct!"
                                          : "❌ Wrong, Answer: ${question.correctAnswer}",
                                    ),
                                  ),
                                );
                              },
                              child: Text(opt.text),
                            ),
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
