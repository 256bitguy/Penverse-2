import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/store/app_state.dart';
import '../reduxx/question_state.dart';
import '../data/question_view_model.dart';

class QuestionsUIScreen extends StatefulWidget {
  final String? topicId;
  const QuestionsUIScreen({super.key, required this.topicId});

  @override
  State<QuestionsUIScreen> createState() => _QuestionsUIScreenState();
}

class _QuestionsUIScreenState extends State<QuestionsUIScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);

    if (widget.topicId != null) {
      Future.microtask(() {
        final store = StoreProvider.of<AppState>(context, listen: false);
        final vm = QuestionsViewModel.fromStore(store);
        vm.fetchQuestions(widget.topicId!);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuestionsViewModel>(
      converter: (store) => QuestionsViewModel.fromStore(store),
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

        if (vm.questions == null || vm.questions!.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No questions found")),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Questions",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey.shade800,
            elevation: 2,
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemCount: vm.questions!.length,
            itemBuilder: (context, index) {
              final question = vm.questions![index];
              return _buildQuestionCard(question);
            },
          ),
        );
      },
    );
  }

  Widget _buildQuestionCard(QuestionModel question) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topic and difficulty
            Row(
              children: [
                const Icon(LucideIcons.bookOpen, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    question.topicName ?? 'Unknown Topic',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question.difficulty,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (question.instructions != null &&
                question.instructions!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  question.instructions!,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),

            if (question.questionText != null &&
                question.questionText!.isNotEmpty)
              Text(
                question.questionText!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),

            const SizedBox(height: 8),

            if (question.images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: question.images
                    .map((img) => _buildRoundedImage(img))
                    .toList(),
              ),

            const SizedBox(height: 8),

            if (question.statements.isNotEmpty)
              ...question.statements.map(
                (s) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(LucideIcons.circleDot,
                          size: 16, color: Colors.blueGrey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          s.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 8),

            if (question.options.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: question.options.map((o) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${String.fromCharCode(65 + o.order)}.",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            o.text,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 12),

            if ((question.solutionText != null &&
                    question.solutionText!.isNotEmpty) ||
                (question.solutionImage != null &&
                    question.solutionImage!.isNotEmpty))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const Text(
                    "Solution:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  if (question.solutionText != null &&
                      question.solutionText!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        question.solutionText!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  if (question.solutionImage != null &&
                      question.solutionImage!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _buildRoundedImage(question.solutionImage!),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedImage(String url, {double size = 100}) {
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
}
