import 'package:flutter/material.dart';
import '../models/VocabPractise.dart';
 

class VocabFillPracticeScreen extends StatefulWidget {
  final List<VocabPractice> vocabList; // ✅ accept list instead of single item

  const VocabFillPracticeScreen({Key? key, required this.vocabList})
      : super(key: key);

  @override
  State<VocabFillPracticeScreen> createState() =>
      _VocabFillPracticeScreenState();
}

class _VocabFillPracticeScreenState extends State<VocabFillPracticeScreen> {
  final TextEditingController _answerController = TextEditingController();
  bool submitted = false;
  int currentIndex = 0; // ✅ keep track of which word we're on

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  /// Function to replace some letters with underscores
  String _maskWord(String word) {
    if (word.length <= 2) return word;
    final chars = word.split('');
    for (int i = 1; i < chars.length - 1; i++) {
      if (i % 2 == 0) chars[i] = '_';
    }
    return chars.join('');
  }

  bool _checkAnswer(String input, String correct) {
    return input.trim().toLowerCase() == correct.trim().toLowerCase();
  }

  void _onCheckPressed() {
    final correctWord = widget.vocabList[currentIndex].word;
    final isCorrect = _checkAnswer(_answerController.text, correctWord);

    setState(() => submitted = true);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: Text(
          isCorrect ? "Cheers! 🎉" : "Not quite",
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          isCorrect
              ? "You entered the correct word!"
              : "Your answer: \"${_answerController.text.trim()}\"\nCorrect word: \"$correctWord\"",
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isCorrect) _goToNextWord(); // move on only if correct
            },
            child:
                const Text("OK", style: TextStyle(color: Colors.tealAccent)),
          ),
        ],
      ),
    );
  }

  void _goToNextWord() {
    if (currentIndex < widget.vocabList.length - 1) {
      setState(() {
        currentIndex++;
        _answerController.clear();
        submitted = false;
      });
    } else {
      // 🎯 all done
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.black87,
          title: const Text("Congratulations!",
              style: TextStyle(color: Colors.white)),
          content: const Text(
            "You've completed all the words!",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK",
                  style: TextStyle(color: Colors.tealAccent)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vocab = widget.vocabList[currentIndex];
    final maskedWord = _maskWord(vocab.word);

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        title: Text(
          "Word ${currentIndex + 1} of ${widget.vocabList.length}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        maskedWord,
                        style: const TextStyle(
                          fontSize: 42,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    if(vocab.meaning.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        "Meaning: ${vocab.meaning}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 24),
                    if (vocab.imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          vocab.imageUrl,
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 200,
                            color: Colors.grey.shade900,
                            child: const Center(
                              child: Text('Image failed to load',
                                  style: TextStyle(color: Colors.white70)),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Bottom input + button
            Container(
              color: Colors.black87,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _answerController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Type the complete word...",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: submitted
                            ? Icon(
                                _checkAnswer(
                                        _answerController.text, vocab.word)
                                    ? Icons.check_circle
                                    : Icons.close,
                                color: _checkAnswer(
                                        _answerController.text, vocab.word)
                                    ? Colors.green
                                    : Colors.red,
                              )
                            : null,
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _onCheckPressed(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.tealAccent[700],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.black),
                      tooltip: "Check",
                      onPressed: _onCheckPressed,
                    ),
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
