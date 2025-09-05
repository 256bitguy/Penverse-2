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
              widget.newsItem.date,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              widget.newsItem.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Background Context
            if (widget.newsItem.backgroundContextTitle != null)
              Text(
                widget.newsItem.backgroundContextTitle ?? "",
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8),
            if (widget.newsItem.backgroundContextPoints.isEmpty != true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (widget.newsItem.backgroundContextPoints as List)
                    .map((point) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "• ${point.title}: ${point.explanation}",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 20),

            // Topic Title
            if (widget.newsItem.topicTitle.isEmpty != true)
              Text(
                widget.newsItem.topicTitle,
                style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8),
            if (widget.newsItem.subTopicTitles.isEmpty != true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (widget.newsItem.subTopicTitles as List)
                    .map((sub) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "${sub.title_statement}: ${sub.points}",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ),
                        ))
                    .toList(),
              ),

            const SizedBox(height: 20),

            // Key Highlights
            if (widget.newsItem.keyHighlightsOfTopic != null)
              const Text(
                "Highlights",
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8),
            if (widget.newsItem.keyHighlightsOfTopic != null)
              Text(
                widget.newsItem.keyHighlightsOfTopic ?? "",
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),

            const SizedBox(height: 20),

            // Conclusion
            if (widget.newsItem.conclusionPoints.isNotEmpty != true)
              const Text(
                "Conclusion",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8),
            if (widget.newsItem.conclusionPoints.isNotEmpty != true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (widget.newsItem.conclusionPoints as List)
                    .map((c) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "${c.title}: ${c.explanation}",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
