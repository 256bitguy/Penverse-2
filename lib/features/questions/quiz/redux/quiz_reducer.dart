import 'quiz_state.dart';
import 'quiz_action.dart';

QuizState quizReducer(QuizState state, dynamic action) {
  if (action is FetchAllQuizzesAction) {
    // Fetch list of quizzes (lightweight items)
    return state.copyWith(isLoading: true, error: '');
  } else if (action is FetchAllQuizzesSuccessAction) {
    return state.copyWith(
      isLoading: false,
      quizList: action.quizList, // only lightweight items
      error: '',
    );
  } else if (action is FetchQuizByIdAction) {
    // Fetch full quiz set by ID
    return state.copyWith(isLoading: true, error: '', selectedQuiz: null);
  } else if (action is FetchQuizByIdSuccessAction) {
    return state.copyWith(
      isLoading: false,
      selectedQuiz: action.quiz, // full quiz with questions
      error: '',
    );
  } else if (action is FetchQuizFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  } else if (action is ClearQuizAction) {
    return QuizState.initial();
  }

  return state;
}
