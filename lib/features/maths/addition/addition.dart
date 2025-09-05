import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AdditionQuiz extends StatefulWidget {
  @override
  _AdditionQuizState createState() => _AdditionQuizState();
}

class _AdditionQuizState extends State<AdditionQuiz> {
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
    int numCount = getRandomInt(2, 5);
    int digits = getRandomInt(2, 3);
    int min = digits == 2 ? 10 : 100;
    int max = digits == 2 ? 99 : 999;

    numbers = List.generate(numCount, (_) => getRandomInt(min, max));
    answer = numbers.reduce((a, b) => a + b);
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
    timer = Timer.periodic(Duration(seconds: 1), (t) {
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
      // backgroundColor: Color(0xFF0D0D25),
      appBar: AppBar(
        title: Text("Addition Quiz"),
        backgroundColor: Color(0xFF0D0D25),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: !timerActive && numbers.isEmpty
              ? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D0D25),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: startQuiz,
                  icon: Icon(Icons.play_arrow),
                  label: Text("Start Quiz", style: TextStyle(fontSize: 18)),
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
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                Icon(Icons.timer, color: Color(0xFF51BDA3)),
                                SizedBox(width: 5),
                                Text("$timeLeft s",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF51BDA3))),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30),

                        // Question
                        Text(
                          numbers.join(" + ") + " = ?",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xD9B8B3D2),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),

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
                            
                            fillColor: Color(0xD95B44C4),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Buttons
                        if (result.isEmpty)
                          ElevatedButton(
                            onPressed:
                                userAnswer.isEmpty ? null : handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xD948A77A),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text("Submit",
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
                          SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: nextQuestion,
                            icon: Icon(Icons.arrow_forward),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            label: Text("Next Question",
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
