import 'package:flutter/material.dart';
import '../redux/notes_state.dart';

class SubtopicPage extends StatelessWidget {
  final SubtopicModel subtopic;

  const SubtopicPage({Key? key, required this.subtopic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subtopic.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional: Subtopic-level images
            if (subtopic.images.isNotEmpty)
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subtopic.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          subtopic.images[index],
                          width: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 50),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),

            // Points vertically
            ...subtopic.points.map((point) => _buildPointCard(context, point)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointCard(BuildContext context, PointModel point) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Point title
            Text(
              point.text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),

            // Explanation
            if (point.explanation.isNotEmpty)
              Text(
                point.explanation,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            const SizedBox(height: 12),

            // Examples
            if (point.examples.isNotEmpty) ...[
              const Text(
                "Examples:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              ...point.examples.map((ex) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(
                            ex,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
            ],

            // Show Images Button
            if (point.images.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: ListView(
                            shrinkWrap: true,
                            children: point.images
                                .map(
                                  (img) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        img,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 150,
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(Icons.broken_image,
                                                  size: 50),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Show Images"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
