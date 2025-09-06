import 'package:flutter/material.dart';
import '../banking_awareness_state.dart';
import '../ui/question_page.dart';

class DailyScreen extends StatefulWidget {
  final BankingAwarenessItem newsItem;

  const DailyScreen({super.key, required this.newsItem});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  @override
  Widget build(BuildContext context) {
    final item = widget.newsItem;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1E23),
        elevation: 0,
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.imageUrl,
                width: screenWidth,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // DATE
            Text(
              item.date,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 8),

            // TITLE
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // BACKGROUND CONTEXT
            if (item.backgroundContextTitle != null &&
                item.backgroundContextPoints.isNotEmpty) ...[
              sectionTitle(item.backgroundContextTitle!, Colors.blueAccent),
              const SizedBox(height: 8),
              ...item.backgroundContextPoints.map((point) => infoCard(
                    title: point.title,
                    description: point.explanation,
                  )),
              const SizedBox(height: 20),
            ],

            // TOPIC AND SUBTOPICS
            if (item.topicTitle.isNotEmpty) ...[
              sectionTitle(item.topicTitle, Colors.orangeAccent),
              const SizedBox(height: 8),
              ...item.subTopicTitles.map((sub) => infoCard(
                    title: sub.titleStatement,
                    description: sub.points,
                  )),
              const SizedBox(height: 20),
            ],

            // KEY HIGHLIGHTS
            if (item.keyHighlightsTitle.isNotEmpty) ...[
              sectionTitle("Key Highlights", Colors.greenAccent),
              const SizedBox(height: 8),
              ...item.keyHighlightsTitle.expand((kh) => kh.points.map((point) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bulletPoint(point.statement, color: Colors.greenAccent),
                        const SizedBox(height: 4),
                        ...point.subStatements.map(
                          (sub) => Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 4),
                            child: bulletPoint(sub,
                                size: 12, color: Colors.white70),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  })),
              const SizedBox(height: 20),
            ],

            // CONSEQUENCES
            if (item.consequencesTitle != null &&
                item.subTopicConsequencesTitle.isNotEmpty) ...[
              sectionTitle(item.consequencesTitle!, Colors.redAccent),
              const SizedBox(height: 8),
              ...item.subTopicConsequencesTitle.map((sub) => infoCard(
                    title: sub.titleStatement,
                    description: sub.points,
                  )),
              const SizedBox(height: 20),
            ],

            // IMPORTANT POINTS
            if (item.importantPoints.isNotEmpty) ...[
              sectionTitle("Important Points", Colors.yellowAccent),
              const SizedBox(height: 8),
              ...item.importantPoints.map((ip) => infoCard(
                    title: ip.title,
                    description: ip.explanation,
                  )),
              const SizedBox(height: 20),
            ],

            // CONCLUSION
            if (item.conclusionPoints.isNotEmpty) ...[
              sectionTitle("Conclusion", Colors.purpleAccent),
              const SizedBox(height: 8),
              ...item.conclusionPoints.map((c) => infoCard(
                    title: c.title,
                    description: c.explanation,
                  )),
              const SizedBox(height: 20),
            ],

            // QUESTIONS
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        QuestionsPage(questions: widget.newsItem.questions),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 196, 186, 214),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Attempt Quiz",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget for section titles
  Widget sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Info card with title and description
  Widget infoCard({required String title, required String description}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E23),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Bullet point for highlights
  Widget bulletPoint(String text,
      {Color color = Colors.white, double size = 14}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(color: color, fontSize: size)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: size),
          ),
        ),
      ],
    );
  }

  /// Quiz question card
}
