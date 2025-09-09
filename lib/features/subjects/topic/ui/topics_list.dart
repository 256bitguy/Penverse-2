// lib/features/subjects/topic/ui/topics_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../data/topic_view_model.dart';
import '../../notes/ui/notes_ui_screen.dart';
import '../../../dailyenglish/phrasalVerbs/ui/daily_phrasal_verbs.dart';
import '../../../dailyenglish/vocabulary/ui/daily_vocab.dart';
import '../../../dailyenglish/idioms/ui/daily_idioms.dart';
import '../../../questions/question/ui/question_ui_screen.dart';

class TopicsListScreen extends StatelessWidget {
  const TopicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TopicsViewModel>(
      converter: (store) => TopicsViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.error != null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error: ${vm.error}",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (vm.topics.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                "No topics found",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Topics",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.topics.length,
            itemBuilder: (context, index) {
              final topic = vm.topics[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    topic.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    'Chapter ID: ${topic.chapterId}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.white54,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.grey[900],
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.menu_book,
                                  color: Colors.white),
                              title: const Text("Questions",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                if (topic.id != null && topic.id.isNotEmpty) {
                                  vm.loadQuestionsByTopic(topic
                                      .id); // Redux action to fetch phrases
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuestionsUIScreen(topicId: topic.id),
                                    ),
                                  );
                                }
                              },
                            ),
                            ListTile(
                              leading:
                                  const Icon(Icons.book, color: Colors.white),
                              title: const Text("Notes",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                vm.loadNotesByTopic(topic.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotesUIScreen()),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.menu_book,
                                  color: Colors.white),
                              title: const Text("Phrasal Verbs",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                if (topic.id != null && topic.id.isNotEmpty) {
                                  vm.loadPhrasesByTopic(topic
                                      .id); // Redux action to fetch phrases
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DailyPhrasalVerbScreen(
                                              topicId: topic.id),
                                    ),
                                  );
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.format_quote,
                                  color: Colors.white),
                              title: const Text("Vocabulary",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                if (topic.id != null && topic.id.isNotEmpty) {
                                  vm.loadVocabByTopic(topic
                                      .id); // Redux action to fetch phrases
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DailyVocabScreen(topicId: topic.id),
                                    ),
                                  );
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.format_quote,
                                  color: Colors.white),
                              title: const Text("Idioms",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                if (topic.id != null && topic.id.isNotEmpty) {
                                  vm.loadIdiomsByTopic(topic
                                      .id); // Redux action to fetch phrases
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DailyIdiomsScreen(topicId: topic.id),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
