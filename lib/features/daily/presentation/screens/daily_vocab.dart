import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class DailyVocabScreen extends StatefulWidget {
  const DailyVocabScreen({super.key});

  @override
  State<DailyVocabScreen> createState() => _DailyVocabScreenState();
}

class _DailyVocabScreenState extends State<DailyVocabScreen> {
  int currentIndex = 0;

  // Dummy vocab data
  final List<Map<String, String>> vocabList = [
    {
      "word": "Serendipity",
      "pos": "Noun",
      "eng": "The occurrence of events by chance in a happy way.",
      "hin": "सौभाग्य से सुखद घटनाएँ होना",
    },
    {
      "word": "Eloquent",
      "pos": "Adjective",
      "eng": "Fluent or persuasive in speaking or writing.",
      "hin": "प्रभावशाली बोलने या लिखने वाला",
    },
    {
      "word": "Ephemeral",
      "pos": "Adjective",
      "eng": "Lasting for a very short time.",
      "hin": "क्षणिक, अल्पकालीन",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width;
    final itemHeight = screenSize.height / 2;

    final vocab = vocabList[currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text(
          "Penverse",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F5D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${currentIndex + 1}/${vocabList.length}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            // Image at top
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                "assets/images/onboarding1.png",
                height: itemHeight,
                width: itemWidth,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Word Name
            Text(
              vocab["word"]!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),

            // Part of speech
            Text(
              vocab["pos"]!,
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 12),

            // English explanation
            Text(
              vocab["eng"]!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // Hindi explanation
            Text(
              vocab["hin"]!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Synonym + Antonym Buttons side by side
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SynonymPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5E5EBC),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Text("Synonyms"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AntonymPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F1F5D),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Text("Antonyms"),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Back - Index Tag - Next
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         setState(() {
            //           currentIndex = (currentIndex - 1 + vocabList.length) %
            //               vocabList.length;
            //         });
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.white10,
            //       ),
            //       child: const Text("Back"),
            //     ),

            //     Align(
            //   alignment: Alignment.centerRight,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         currentIndex = (currentIndex - 1 + vocabList.length) %
            //               vocabList.length;
            //       });
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF0D0D25),
            //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  
            //     ),
            //     child: const Text("Next"),
            //   ),
            // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class SynonymPage extends StatelessWidget {
  const SynonymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D25),
      appBar: AppBar(
        title: const Text("Synonyms"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          "Synonym list goes here...",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

// Antonyms Page
class AntonymPage extends StatelessWidget {
  const AntonymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D25),
      appBar: AppBar(
        title: const Text("Antonyms"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: const Center(
        child: Text(
          "Antonym list goes here...",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
