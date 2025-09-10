// quiz_action.dart
import 'quiz_state.dart';

/// ---------------- FETCH QUIZ LIST ----------------

/// Trigger fetching all quizzes for a topic
class FetchAllQuizzesAction {
  final String topicId;
  FetchAllQuizzesAction(this.topicId);
}

/// Successfully fetched quiz list (lightweight items)
class FetchAllQuizzesSuccessAction {
  final List<QuizListItem> quizList;
  FetchAllQuizzesSuccessAction(this.quizList);
}

/// ---------------- FETCH SINGLE QUIZ ----------------

/// Trigger fetching a quiz set by its ID
class FetchQuizByIdAction {
  final String quizId;
  FetchQuizByIdAction(this.quizId);
}

/// Successfully fetched a full quiz with questions
class FetchQuizByIdSuccessAction {
  final QuizModel quiz;
  FetchQuizByIdSuccessAction(this.quiz);
}

/// ---------------- ERROR & CLEAR ----------------

/// Failed to fetch (list or single quiz)
class FetchQuizFailureAction {
  final String error;
  FetchQuizFailureAction(this.error);
}

/// Clear quiz state completely
class ClearQuizAction {}
