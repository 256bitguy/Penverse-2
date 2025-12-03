// lib/features/quiz/ui/quiz_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../data/quiz_view_model.dart';
import '../redux/quiz_action.dart';
import 'quiz_detail_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuizViewModel>(
      converter: (store) => QuizViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.error.isNotEmpty) {
          return Scaffold(
            body: Center(child: Text("Error: ${vm.error}")),
          );
        }

        final quizzes = vm.quizList;

        return Scaffold(
          appBar: AppBar(title: const Text("Available Quizzes")),
          body: ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
            
            return Card(
  child: ListTile(
    title: Text(quiz.title),
    onTap: () async {
      // 1️⃣ Force print the quiz ID
     

      // 2️⃣ Dispatch action to fetch full quiz
      StoreProvider.of<AppState>(context)
          .dispatch(FetchQuizByIdAction(quiz.id));

      // 3️⃣ Navigate to detail screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QuizDetailScreen(quizId: quiz.id),
        ),
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
