// topic_list_file.dart

import 'package:flutter/material.dart';
import 'package:Penverse/features/subjects/notes/redux/notes_state.dart';
import 'subtopic_file.dart'; // jab ready ho to uncomment

class TopicListScreen extends StatelessWidget {
  final TopicModel topic;

  const TopicListScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final List<String> images = topic.images;
    final subtopics = topic.subtopics;

    return Scaffold(
      appBar: AppBar(
        title: Text(topic.name.isNotEmpty ? topic.name : "Topic"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Image carousel (if available)
          if (images.isNotEmpty)
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: images.length,
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.broken_image)),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 16),

          // Subtopics list
          Expanded(
            child: ListView.builder(
              itemCount: subtopics.length,
              itemBuilder: (context, index) {
                final subtopic = subtopics[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
               
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: Color.fromARGB(255, 222, 217, 217)),
                ),
              ),
                    title: Text(subtopic.name.isNotEmpty ? subtopic.name : "Subtopic"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubtopicPage(subtopic: subtopic),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
