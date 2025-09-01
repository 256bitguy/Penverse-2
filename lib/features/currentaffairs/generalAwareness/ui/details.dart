import 'package:flutter/material.dart';
import '../banking_awareness_state.dart';

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
            // Date & Title
            Text(
              item.date,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Background Context
            if (item.backgroundContextTitle != null) ...[
              Text(
                item.backgroundContextTitle!,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (item.backgroundContextPoints.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.backgroundContextPoints
                    .map((point) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "• ${point.title}: ${point.explanation}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 20),

            // Topic Title
            if (item.topicTitle.isNotEmpty) ...[
              Text(
                item.topicTitle,
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (item.subTopicTitles.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.subTopicTitles
                    .map((sub) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "${sub.titleStatement}: ${sub.points}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 20),

            // Key Highlights
            if (item.keyHighlightsOfTopic != null) ...[
              const Text(
                "Highlights",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.keyHighlightsOfTopic!,
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 20),
            ],

            // Conclusion
            if (item.conclusionPoints.isNotEmpty) ...[
              const Text(
                "Conclusion",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.conclusionPoints
                    .map((c) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "${c.title}: ${c.explanation}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
