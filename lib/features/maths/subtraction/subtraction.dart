import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SubtractionQuiz extends StatefulWidget {
  const SubtractionQuiz({super.key});

  @override
  _SubtractionQuizState createState() => _SubtractionQuizState();
}

class _SubtractionQuizState extends State<SubtractionQuiz> {
  List<int> numbers = [];
  int answer = 0;
  String userAnswer = '';
  String result = '';
  int timeLeft = 30;
  bool timerActive = false;
  int score = 0;
  int attempts = 0;
  Timer? timer;

  Random random = Random();

  int getRandomInt(int min, int max) {
    return min + random.nextInt(max - min + 1);
  }

  void generateQuestion() {
    int numCount = getRandomInt(2, 4); // fewer numbers for subtraction
    int digits = getRandomInt(2, 3);
    int min = digits == 2 ? 10 : 100;
    int max = digits == 2 ? 99 : 999;

    numbers = List.generate(numCount, (_) => getRandomInt(min, max));

    // ensure non-negative result
    numbers.sort((a, b) => b.compareTo(a)); 
    answer = numbers.reduce((a, b) => a - b);
  }

  void startQuiz() {
    setState(() {
      score = 0;
      attempts = 0;
      result = '';
      userAnswer = '';
      generateQuestion();
      timeLeft = 30;
      timerActive = true;
    });
    startTimer();
  }

  void nextQuestion() {
    setState(() {
      result = '';
      userAnswer = '';
      generateQuestion();
      timeLeft = 30;
      timerActive = true;
    });
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!timerActive) {
        t.cancel();
        return;
      }
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          handleSubmit();
        }
      });
    });
  }

  void handleSubmit() {
    timerActive = false;
    timer?.cancel();
    bool isCorrect = int.tryParse(userAnswer) == answer;
    setState(() {
      result = isCorrect
          ? "✅ Correct!"
          : "❌ Wrong! Correct answer: $answer";
      if (isCorrect) score++;
      attempts++;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Subtraction Quiz"),
        backgroundColor: const Color(0xFF0D0D25),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: !timerActive && numbers.isEmpty
              ? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D0D25),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: startQuiz,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Quiz", style: TextStyle(fontSize: 18)),
                )
              : Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Score & Timer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Score: $score / $attempts",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                const Icon(Icons.timer, color: Color.fromARGB(255, 105, 54, 244)),
                                const SizedBox(width: 5),
                                Text("$timeLeft s",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Question
                        Text(
                          "${numbers.join(" - ")} = ?",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 167, 164, 212),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),

                        // Answer input
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) => setState(() => userAnswer = val),
                          enabled: timerActive,
                          decoration: InputDecoration(
                            hintText: "Enter your answer",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Buttons
                        if (result.isEmpty)
                          ElevatedButton(
                            onPressed:
                                userAnswer.isEmpty ? null : handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Submit",
                                style: TextStyle(fontSize: 18)),
                          ),
                        if (result.isNotEmpty) ...[
                          Text(
                            result,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: result.contains("Correct")
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: nextQuestion,
                            icon: const Icon(Icons.arrow_forward),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 108, 103, 182),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            label: const Text("Next Question",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
