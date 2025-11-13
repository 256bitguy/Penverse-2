import 'package:flutter/material.dart';
import '../vocab_state.dart';

class VocabPracticeScreen extends StatefulWidget {
  final VocabItem vocabItem;

  const VocabPracticeScreen({Key? key, required this.vocabItem})
      : super(key: key);

  @override
  State<VocabPracticeScreen> createState() => _VocabPracticeScreenState();
}

class _VocabPracticeScreenState extends State<VocabPracticeScreen> {
  late TextEditingController mainWordController;
  late List<TextEditingController> synonymControllers;
  late List<TextEditingController> antonymControllers;
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    final vocab = widget.vocabItem;

    mainWordController = TextEditingController();
    synonymControllers =
        List.generate(vocab.synonyms.length, (_) => TextEditingController());
    antonymControllers =
        List.generate(vocab.antonyms.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    mainWordController.dispose();
    for (var c in synonymControllers) c.dispose();
    for (var c in antonymControllers) c.dispose();
    super.dispose();
  }

  bool _checkAnswer(String input, String correct) {
    return input.trim().toLowerCase() == correct.trim().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final vocab = widget.vocabItem;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        title: Text(vocab.word, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// MAIN WORD SECTION
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Main Word:",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// ✅ Explanation hint
                  if (vocab.explanations.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vocab.explanations.first.englishExplanation,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 14),
                        ),
                        if (vocab.explanations.first.hindiExplanation.isNotEmpty)
                          Text(
                            vocab.explanations.first.hindiExplanation,
                            style: const TextStyle(
                                color: Colors.white38, fontSize: 13),
                          ),
                        const SizedBox(height: 8),
                      ],
                    ),

                  if (vocab.imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        vocab.imageUrl,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: mainWordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter the word here...",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.black54,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: submitted
                          ? Icon(
                              _checkAnswer(
                                      mainWordController.text, vocab.word)
                                  ? Icons.check_circle
                                  : Icons.close,
                              color: _checkAnswer(
                                      mainWordController.text, vocab.word)
                                  ? Colors.green
                                  : Colors.red,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// SYNONYMS SECTION
            _buildWordGroup(
              title: "Synonyms",
              items: vocab.synonyms.map((e) => e.word).toList(),
              hints: vocab.synonyms.map((e) => e.meaning).toList(),
              controllers: synonymControllers,
            ),

            const SizedBox(height: 24),

            /// ANTONYMS SECTION
            _buildWordGroup(
              title: "Antonyms",
              items: vocab.antonyms.map((e) => e.word).toList(),
              hints: vocab.antonyms.map((e) => e.meaning).toList(),
              controllers: antonymControllers,
            ),

            const SizedBox(height: 24),

            /// SUBMIT BUTTON
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[700],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  setState(() {
                    submitted = true;
                  });
                },
                child: const Text(
                  "Check Answers",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordGroup({
    required String title,
    required List<String> items,
    required List<String> hints,
    required List<TextEditingController> controllers,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          for (int i = 0; i < items.length; i++) ...[
            if (hints[i].isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  "Hint: ${hints[i]}",
                  style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 13,
                      fontStyle: FontStyle.italic),
                ),
              ),
            TextField(
              controller: controllers[i],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter ${title.toLowerCase()} ${i + 1}",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: Colors.black54,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: submitted
                    ? Icon(
                        _checkAnswer(controllers[i].text, items[i])
                            ? Icons.check_circle
                            : Icons.close,
                        color: _checkAnswer(controllers[i].text, items[i])
                            ? Colors.green
                            : Colors.red,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
