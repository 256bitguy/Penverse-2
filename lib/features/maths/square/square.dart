import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SquareQuiz extends StatefulWidget {
  @override
  _SquareQuizState createState() => _SquareQuizState();
}

class _SquareQuizState extends State<SquareQuiz> {
  int number = 0;
  int answer = 0;
  String userAnswer = '';
  String result = '';
  int score = 0;
  int attempts = 0;
  bool randomMode = true;

  Random random = Random();

  void generateQuestion({bool randomGen = true}) {
    if (randomGen) {
      number = random.nextInt(30) + 2; // random 2–31
    }
    answer = number * number;
  }

  void toggleMode(bool isRandom) {
    setState(() {
      randomMode = isRandom;
      number = isRandom ? random.nextInt(30) + 2 : 2;
      userAnswer = '';
      result = '';
      generateQuestion(randomGen: isRandom);
    });
  }

  void handleSubmit() {
    bool isCorrect = int.tryParse(userAnswer) == answer;
    setState(() {
      result = isCorrect
          ? "✅ Correct!"
          : "❌ Wrong! Correct answer: $answer";
      if (isCorrect) score++;
      attempts++;
    });
  }

  void nextQuestion() {
    setState(() {
      result = '';
      userAnswer = '';
      generateQuestion(randomGen: randomMode);
    });
  }

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Square Prediction Quiz"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mode Switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: Text("Random Mode"),
                        selected: randomMode,
                        onSelected: (val) => toggleMode(true),
                      ),
                      SizedBox(width: 12),
                      ChoiceChip(
                        label: Text("Manual Mode"),
                        selected: !randomMode,
                        onSelected: (val) => toggleMode(false),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Score
                  Text("Score: $score / $attempts",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20),

                  // Manual Controls
                  if (!randomMode) Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            number = (number > 2) ? number - 1 : 2;
                            generateQuestion(randomGen: false);
                          });
                        },
                        icon: Icon(Icons.remove_circle, color: Colors.red, size: 32),
                      ),
                      Text("$number",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            number++;
                            generateQuestion(randomGen: false);
                          });
                        },
                        icon: Icon(Icons.add_circle, color: Colors.green, size: 32),
                      ),
                    ],
                  ),

                  // Question
                  SizedBox(height: 30),
                  Text(
                    "$number² = ?",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Answer input
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) => setState(() => userAnswer = val),
                    decoration: InputDecoration(
                      hintText: "Enter your answer",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      
                    ),
                  ),
                  SizedBox(height: 20),

                  // Buttons
                  if (result.isEmpty)
                    ElevatedButton(
                      onPressed: userAnswer.isEmpty ? null : handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Submit", style: TextStyle(fontSize: 18)),
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
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      label:
                          Text("Next Question", style: TextStyle(fontSize: 18)),
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
