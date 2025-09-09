import 'phrasal_verb_state.dart';

/// Action to start loading phrasal verbs
class LoadPhrasalVerbsAction {}

class FetchPhrasesByTopicIdAction {
  final String topicId;
  FetchPhrasesByTopicIdAction(this.topicId);
}

/// Action when phrasal verbs load successfully
class LoadPhrasalVerbsSuccessAction {
  final List<PhrasalVerbItem> items;
  LoadPhrasalVerbsSuccessAction(this.items);
}

/// Action when phrasal verbs loading fails
class LoadPhrasalVerbsFailureAction {
  final String error;
  LoadPhrasalVerbsFailureAction(this.error);
}
