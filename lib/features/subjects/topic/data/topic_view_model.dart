// lib/features/subjects/topic/data/topic_view_model.dart

import 'package:redux/redux.dart';
import '../../../../core/store/app_state.dart';
import '../redux/topic_state.dart';
import '../../notes/redux/notes_action.dart';
import '../../../currentaffairs/generalAwareness/banking_awareness_actions.dart';
import '../../../dailyenglish/phrasalVerbs/phrasal_verbs_actions.dart';
import '../../../dailyenglish/idioms/idioms_actions.dart';
import '../../../dailyenglish/vocabulary/vocab_actions.dart';
import '../../../questions/question/reduxx/question_action.dart';
class TopicsViewModel {
  final bool isLoading;
  final List<Topic> topics;
  final String? error;
final Function(String topicId) loadNotesByTopic;
final Function(String topicId) loadVocabByTopic;
final Function(String topicId) loadIdiomsByTopic;
final Function(String topicId) loadPhrasesByTopic;
final Function(String topicId) loadAwarenessByTopic; 
final Function(String topicId) loadQuestionsByTopic;

  TopicsViewModel({
    required this.isLoading,
    required this.topics,
    this.error,
    required this.loadNotesByTopic,
    required this.loadVocabByTopic,
    required this.loadIdiomsByTopic,
    required this.loadPhrasesByTopic,
    required this.loadAwarenessByTopic,
    required this.loadQuestionsByTopic,
  });

  /// Map Redux state to ViewModel
  static TopicsViewModel fromStore(Store<AppState> store) {
    final state = store.state.topicState;
    return TopicsViewModel(
      isLoading: state.isLoading,
      topics: state.topics ?? [], // same type as Redux
      error: state.error,
      loadNotesByTopic: (topicId){
         store.dispatch(FetchNoteByTopicIdAction(topicId));
      },loadVocabByTopic: (topicId){
         store.dispatch(FetchVocabByTopicIdAction(topicId));
      },loadIdiomsByTopic: (topicId){
         store.dispatch(FetchIdiomsByTopicIdAction(topicId));
      },loadPhrasesByTopic: (topicId){
         store.dispatch(FetchPhrasesByTopicIdAction(topicId));
      },loadAwarenessByTopic: (topicId){
         store.dispatch(FetchAwarenessByTopicIdAction(topicId));
      },
      loadQuestionsByTopic: (topicId){
         store.dispatch(FetchQuestionsByTopicIdAction(topicId));
      }
    );
  }
}
