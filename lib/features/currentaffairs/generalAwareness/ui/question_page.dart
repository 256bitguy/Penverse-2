import 'package:flutter/material.dart';
import '../banking_awareness_state.dart'; // <-- Import your model

class QuestionsPage extends StatefulWidget {
  final List<Question> questions; // ✅ Using Question model directly

  const QuestionsPage({super.key, required this.questions});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  Map<int, String> selectedAnswers = {};
  bool isSubmitted = false;
  int score = 0;

  void submitQuiz() {
    int correct = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      final question = widget.questions[i];
      if (selectedAnswers[i] == question.correctOption) {
        correct++;
      }
    }
    setState(() {
      score = correct;
      isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = widget.questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1E23),
        title: const Text(
          "Practice Questions",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isSubmitted
          ? _buildResultView(totalQuestions)
          : _buildQuizView(totalQuestions),
    );
  }

  /// Quiz View Before Submission
  Widget _buildQuizView(int totalQuestions) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(widget.questions.length, (index) {
            final question = widget.questions[index];
            return _buildQuestionCard(index, question, totalQuestions);
          }),

          const SizedBox(height: 20),

          // Submit button
          Center(
            child: ElevatedButton(
              onPressed: selectedAnswers.length == totalQuestions
                  ? submitQuiz
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Submit Quiz",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Result View After Submission
  Widget _buildResultView(int totalQuestions) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Quiz Completed!",
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Your Score: $score / $totalQuestions",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Back to Article",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Question Card Widget
  Widget _buildQuestionCard(int index, Question question, int totalQuestions) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E23),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question number
          Text(
            "Question ${index + 1} of $totalQuestions",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),

          // Question statement
          Text(
            question.statement,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Options
          ...List.generate(question.options.length, (optIndex) {
            final option = question.options[optIndex];
            final isSelected = selectedAnswers[index] == option;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedAnswers[index] = option;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal.withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.tealAccent : Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected ? Colors.tealAccent : Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.tealAccent : Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
