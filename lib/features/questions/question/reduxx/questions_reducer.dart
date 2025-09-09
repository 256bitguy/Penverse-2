// questions_reducer.dart
import 'question_state.dart';
import 'question_action.dart';

QuestionsState questionsReducer(QuestionsState state, dynamic action) {
  if (action is FetchQuestionsByTopicIdAction) {
    return state.copyWith(isLoading: true, error: '');
  } else if (action is FetchQuestionsSuccessAction) {
    return state.copyWith(
      isLoading: false,
      questions: action.questions,
      error: '',
    );
  } else if (action is FetchQuestionsFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  } else if (action is ClearQuestionsAction) {
    return QuestionsState.initial();
  }
  return state;
}
