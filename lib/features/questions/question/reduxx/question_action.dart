// questions_action.dart
import 'question_state.dart';

/// Trigger fetching questions for a topic
class FetchQuestionsByTopicIdAction {
  final String topicId;
  FetchQuestionsByTopicIdAction(this.topicId);
}

/// Successfully fetched questions
class FetchQuestionsSuccessAction {
  final List<QuestionModel> questions; // list of questions
  FetchQuestionsSuccessAction(this.questions);
}

/// Failed to fetch questions
class FetchQuestionsFailureAction {
  final String error;
  FetchQuestionsFailureAction(this.error);
}

/// Clear questions state
class ClearQuestionsAction {}
