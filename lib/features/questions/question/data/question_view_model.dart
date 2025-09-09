import 'package:redux/redux.dart';

import '../reduxx/question_state.dart';
import '../reduxx/question_action.dart';
import '../../../../core/store/app_state.dart';

class QuestionsViewModel {
  final bool isLoading;
  final List<QuestionModel> questions; // list of questions
  final String error;
  final Function(String topicId) fetchQuestions;

  QuestionsViewModel({
    required this.isLoading,
    required this.questions,
    required this.error,
    required this.fetchQuestions,
  });

  static QuestionsViewModel fromStore(Store<AppState> store) {
    return QuestionsViewModel(
      isLoading: store.state.questionsState.isLoading,
      questions: store.state.questionsState.questions ,
      error: store.state.questionsState.error,
      fetchQuestions: (topicId) =>
          store.dispatch(FetchQuestionsByTopicIdAction(topicId)),
    );
  }
}
