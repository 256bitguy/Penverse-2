import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FractionDecimalQuiz(),
  ));
}

class FractionDecimalQuiz extends StatefulWidget {
  const FractionDecimalQuiz({super.key});

  @override
  State<FractionDecimalQuiz> createState() => _FractionDecimalQuizState();
}

class _FractionDecimalQuizState extends State<FractionDecimalQuiz> {
  final Random _random = Random();
  String question = "";
  String correctAnswer = "";
  List<String> options = [];
  String? selectedAnswer;
  bool showResult = false;

  // Controls quiz mode
  bool isFracToDecMode = true;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  int gcd(int a, int b) => b == 0 ? a : gcd(b, a % b);

  Map<String, int> simplifyFraction(int n, int d) {
    int g = gcd(n, d);
    return {"n": n ~/ g, "d": d ~/ g};
  }

  void generateQuestion() {
    int n = _random.nextInt(9) + 1;
    int d = _random.nextInt(9) + n + 1;
    var frac = simplifyFraction(n, d);

    double decimal = (frac["n"]! / frac["d"]!).toDouble();
    String decStr = decimal.toStringAsFixed(2);

    if (isFracToDecMode) {
      question = "${frac["n"]}/${frac["d"]}";
      correctAnswer = decStr;
      options = _generateOptions(decStr, false);
    } else {
      question = decStr;
      correctAnswer = "${frac["n"]}/${frac["d"]}";
      options = _generateOptions(correctAnswer, true);
    }

    selectedAnswer = null;
    showResult = false;
    setState(() {});
  }

  List<String> _generateOptions(String correct, bool isFraction) {
    Set<String> opts = {correct};

    while (opts.length < 4) {
      if (isFraction) {
        int n = _random.nextInt(9) + 1;
        int d = _random.nextInt(9) + n + 1;
        var frac = simplifyFraction(n, d);
        opts.add("${frac["n"]}/${frac["d"]}");
      } else {
        double offset = (_random.nextInt(20) - 10) / 100.0;
        double val = double.parse(correct) + offset;
        if (val > 0 && val < 1) {
          opts.add(val.toStringAsFixed(2));
        }
      }
    }

    List<String> list = opts.toList();
    list.shuffle();
    return list;
  }

  void handleAnswer(String val) {
    setState(() {
      selectedAnswer = val;
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D25),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 🔘 Toggle Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Fraction → Decimal",
                      style: TextStyle(fontSize: 16)),
                  Switch(
                    value: !isFracToDecMode,
                    onChanged: (val) {
                      setState(() {
                        isFracToDecMode = !val ? true : false;
                        generateQuestion();
                      });
                    },
                  ),
                  const Text("Decimal → Fraction",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 20),

              // Question type text
              Text(
                isFracToDecMode
                    ? "Convert Fraction → Decimal"
                    : "Convert Decimal → Fraction",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Question Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
               
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    question,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Options
              ...options.map((opt) {
                bool isCorrect = opt == correctAnswer;
                bool isSelected = opt == selectedAnswer;

                Color btnColor = const Color.fromARGB(255, 82, 71, 180);
                if (showResult) {
                  if (isCorrect) {
                    btnColor = Colors.green.shade400;
                  } else if (isSelected && !isCorrect) {
                    btnColor = Colors.red.shade400;
                  } else {
                    btnColor = Colors.grey.shade300;
                  }
                }

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed:
                        showResult ? null : () => handleAnswer(opt),
                    child: Text(opt,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // ✅❌ Feedback
              if (showResult)
                Text(
                  selectedAnswer == correctAnswer
                      ? "✅ Correct!"
                      : "❌ Wrong! Answer: $correctAnswer",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: selectedAnswer == correctAnswer
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

              const SizedBox(height: 20),

              // Next Question button
              if (showResult)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: generateQuestion,
                  child: const Text("Next Question",
                      style:
                          TextStyle(fontSize: 18, color: Colors.white)),
                )
            ],
          ),
        ),
      ),
    );
  }
}
