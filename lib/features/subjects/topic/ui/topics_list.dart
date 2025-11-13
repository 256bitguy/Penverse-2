import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../data/topic_view_model.dart';
import '../../notes/ui/notes_ui_screen.dart';
import '../../../dailyenglish/phrasalVerbs/ui/daily_phrasal_verbs.dart';
import '../../../dailyenglish/vocabulary/ui/daily_vocab.dart';
import '../../../dailyenglish/idioms/ui/daily_idioms.dart';
import '../../../questions/question/ui/question_ui_screen.dart';

class TopicsListScreen extends StatefulWidget {
  const TopicsListScreen({super.key});

  @override
  State<TopicsListScreen> createState() => _TopicsListScreenState();
}

class _TopicsListScreenState extends State<TopicsListScreen> {
  int? _selectedTopicIndex;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TopicsViewModel>(
      converter: (store) => TopicsViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFF0E0E0E),
            body: Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ),
          );
        }

        if (vm.error != null) {
          return Scaffold(
            backgroundColor: const Color(0xFF0E0E0E),
            body: Center(
              child: Text(
                "Error: ${vm.error}",
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          );
        }

        if (vm.topics.isEmpty) {
          return const Scaffold(
            backgroundColor: Color(0xFF0E0E0E),
            body: Center(
              child: Text(
                "No topics found",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF0E0E0E),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Topics",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 2,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: vm.topics.length,
            itemBuilder: (context, index) {
              final topic = vm.topics[index];
              final bool isSelected = _selectedTopicIndex == index;

              return Card(
                color: const Color(0xFF1A1A1A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected ? Colors.blueAccent : Colors.grey.shade800,
                    width: 1,
                  ),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor:
                        isSelected ? Colors.blueAccent : Colors.grey.shade700,
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    topic.title,
                    style: TextStyle(
                      color: isSelected ? Colors.blueAccent : Colors.white,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.menu_rounded, color: Colors.white70),
                    onPressed: () {
                      setState(() => _selectedTopicIndex = index);
                      _showTopicOptions(context, vm, topic);
                    },
                  ),
                  onTap: () {
                    setState(() => _selectedTopicIndex = index);
                    _showTopicOptions(context, vm, topic);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showTopicOptions(BuildContext context, TopicsViewModel vm, dynamic topic) {
  final List<dynamic> types = 
  // (topic.types != null && topic.types.isNotEmpty)
  //     ? topic.types
  //     :
       ["notes", "vocab"]; // 👈 default if none



    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),

              // Dynamically build from topic.types
              for (var type in types) _buildOptionByType(type, context, vm, topic),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionByType(String type, BuildContext context, TopicsViewModel vm, dynamic topic) {
    switch (type) {
      case 'questions':
        return _buildOption(
          icon: Icons.quiz,
          label: "Questions",
          onTap: () {
            Navigator.pop(context);
            vm.loadQuestionsByTopic(topic.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionsUIScreen(topicId: topic.id),
              ),
            );
          },
        );
      case 'notes':
        return _buildOption(
          icon: Icons.note_alt,
          label: "Notes",
          onTap: () {
            Navigator.pop(context);
            vm.loadNotesByTopic(topic.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotesUIScreen(),
              ),
            );
          },
        );
      case 'vocab':
        return _buildOption(
          icon: Icons.translate,
          label: "Vocabulary",
          onTap: () {
            Navigator.pop(context);
            vm.loadVocabByTopic(topic.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DailyVocabScreen(topicId: topic.id),
              ),
            );
          },
        );
      case 'phrasal_verbs':
        return _buildOption(
          icon: Icons.book,
          label: "Phrasal Verbs",
          onTap: () {
            Navigator.pop(context);
            vm.loadPhrasesByTopic(topic.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DailyPhrasalVerbScreen(topicId: topic.id),
              ),
            );
          },
        );
      case 'idioms':
        return _buildOption(
          icon: Icons.lightbulb,
          label: "Idioms",
          onTap: () {
            Navigator.pop(context);
            vm.loadIdiomsByTopic(topic.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DailyIdiomsScreen(topicId: topic.id),
              ),
            );
          },
        );
      default:
        return _buildOption(
          icon: Icons.help_outline,
          label: type,
          onTap: () => Navigator.pop(context),
        );
    }
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
