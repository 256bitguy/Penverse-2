import 'package:redux/redux.dart';
import '../redux/quiz_state.dart';
import '../redux/quiz_action.dart';
import '../../../../core/store/app_state.dart';

class QuizViewModel {
  final bool isLoading;
  final List<QuizListItem> quizList; // lightweight list of quizzes
  final QuizModel? selectedQuiz;     // full quiz with questions
  final String error;

  // Actions
  final Function(String topicId) fetchAllQuizzesByTopic;
  final Function(String quizId) fetchQuizById;
  final Function clearQuiz;

  QuizViewModel({
    required this.isLoading,
    required this.quizList,
    required this.selectedQuiz,
    required this.error,
    required this.fetchAllQuizzesByTopic,
    required this.fetchQuizById,
    required this.clearQuiz,
  });

  static QuizViewModel fromStore(Store<AppState> store) {
    return QuizViewModel(
      isLoading: store.state.quizState.isLoading,
      quizList: store.state.quizState.quizList,
      selectedQuiz: store.state.quizState.selectedQuiz,
      error: store.state.quizState.error,

      // Dispatchers
      fetchAllQuizzesByTopic: (topicId) =>
          store.dispatch(FetchAllQuizzesAction(topicId)),
      fetchQuizById: (quizId) =>
          store.dispatch(FetchQuizByIdAction(quizId)),
      clearQuiz: () =>
          store.dispatch(ClearQuizAction()),
    );
  }
}
