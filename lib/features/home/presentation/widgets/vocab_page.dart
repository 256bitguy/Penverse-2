import 'package:flutter/material.dart';

class VocabScreen extends StatefulWidget {
  const VocabScreen({super.key});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
  final List<String> _vocabList = [];
  final TextEditingController _controller = TextEditingController();

  void _addVocab() {
    final newWord = _controller.text.trim();
    if (newWord.isNotEmpty) {
      setState(() {
        _vocabList.insert(0, newWord); // Add to the top of the list
      });
      _controller.clear(); // Clear the text field
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vocabulary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // List of added words (newest on top)
            Expanded(
              child: _vocabList.isEmpty
                  ? const Center(child: Text('No vocab added yet.'))
                  : ListView.builder(
                      itemCount: _vocabList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_vocabList[index]),
                        );
                      },
                    ),
            ),

            // Text input and button
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a word',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addVocab(), // Optionally add on enter
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _addVocab,
              icon: const Icon(Icons.add),
              label: const Text('Add Word'),
            ),
          ],
        ),
      ),
    );
  }
}
