import 'package:Penverse/core/store/app_state.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/notes_state.dart';
import '../data/notes_view_model.dart';

class NotesUIScreen extends StatelessWidget {
  const NotesUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NotesViewModel>(
      converter: (store) => NotesViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.error.isNotEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error: ${vm.error}",
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }

        if (vm.note == null) {
          return const Scaffold(
            body: Center(child: Text("No note found")),
          );
        }

        final note = vm.note!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              note.heading,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey.shade800,
            elevation: 2,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Note Images
              if (note.images.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: note.images
                      .map((img) => _buildRoundedImage(img, size: 100))
                      .toList(),
                ),
              const SizedBox(height: 20),

              // All Topics Fully Expanded
              ...note.topics.map((topic) => _buildTopicSection(topic)).toList(),
            ],
          ),
        );
      },
    );
  }

  /// Reusable rounded image widget
  Widget _buildRoundedImage(String url, {double size = 80}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        height: size,
        width: size,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Fully expanded topic section
  Widget _buildTopicSection(TopicModel topic) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.bookOpen, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(
                  topic.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Topic Images
            if (topic.images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: topic.images
                    .map((img) => _buildRoundedImage(img, size: 80))
                    .toList(),
              ),
            const SizedBox(height: 12),

            // Subtopics - fully expanded
            ...topic.subtopics.map((subtopic) => _buildSubtopicSection(subtopic)).toList(),
          ],
        ),
      ),
    );
  }

  /// Fully expanded subtopic section
  Widget _buildSubtopicSection(SubtopicModel subtopic) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color.fromARGB(255, 127, 127, 196),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.layers, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  subtopic.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Subtopic Images
            if (subtopic.images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: subtopic.images
                    .map((img) => _buildRoundedImage(img, size: 70))
                    .toList(),
              ),
            const SizedBox(height: 10),

            // Points - fully visible
            ...subtopic.points.map((point) => _buildPointCard(point)).toList(),
          ],
        ),
      ),
    );
  }

  /// Point card - fully visible
  Widget _buildPointCard(PointModel point) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: const Color.fromARGB(255, 174, 212, 135),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (point.text.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LucideIcons.circleDot, size: 18, color: Colors.blueGrey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      point.text,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),

            if (point.explanation.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 24),
                child: Text(
                  point.explanation,
                  style:  TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 211, 143, 143),
                  ),
                ),
              ),

            // Point Images
            if (point.images.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: point.images
                    .map((img) => _buildRoundedImage(img, size: 60))
                    .toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
