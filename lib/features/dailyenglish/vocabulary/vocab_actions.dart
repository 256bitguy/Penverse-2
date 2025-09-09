import 'vocab_state.dart';

/// Action to start loading vocab (usually triggers middleware / async fetch)
class LoadVocabAction {}
class FetchVocabByTopicIdAction {
  final String topicId;
  FetchVocabByTopicIdAction(this.topicId);
}

/// Action when vocab loads successfully
class LoadVocabSuccessAction {
  final List<VocabItem> items;
  LoadVocabSuccessAction(this.items);
}
/// Action when vocab loading fails
class LoadVocabFailureAction {
  final String error;
  LoadVocabFailureAction(this.error);
}
