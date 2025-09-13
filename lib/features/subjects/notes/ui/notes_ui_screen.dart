import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../questions/quiz/redux/quiz_action.dart';
import '../../../questions/quiz/ui/quiz_list_screen.dart';
import '../redux/notes_state.dart';
import '../data/notes_view_model.dart';
import '../../../../core/store/app_state.dart';
import 'topic_list_file.dart';

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
          body: Column(
            children: [
              const SizedBox(height: 20),

              // Note image (centered if available)
              if (note.images.isNotEmpty)
                Center(
                  child: Image.network(
                    note.images.first,
                    height: 600,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                ),

              const Spacer(),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(LucideIcons.bookOpen, color: Colors.white),
                      label: const Text(
                        "Topics",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        _showTopicsModal(context, note);
                      },
                    ),
                    const SizedBox(height: 16),
                    StoreConnector<AppState, void Function()>(
                      converter: (store) {
                        return () {
                          store.dispatch(FetchAllQuizzesAction(note.id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const QuizListScreen()),
                          );
                        };
                      },
                      builder: (context, startQuiz) {
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(LucideIcons.bookCheck, color: Colors.white),
                          label: const Text(
                            "Practise",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: startQuiz,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTopicsModal(BuildContext context, NoteModel note) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: note.topics.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final topic = note.topics[index];
            return ListTile(
              leading: CircleAvatar(
               
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: Color.fromARGB(255, 222, 217, 217)),
                ),
              ),
              title: Text(
                topic.name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context); // close modal
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TopicListScreen(topic: topic),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
