import 'idioms_state.dart';

 
/// Action to start loading idioms
class LoadIdiomsAction {}
class FetchIdiomsByTopicIdAction {
  final String topicId;
  FetchIdiomsByTopicIdAction(this.topicId);
}
/// Action when idioms load successfully
class LoadIdiomsSuccessAction {
  final List<IdiomItem> items;
  LoadIdiomsSuccessAction(this.items);
}

/// Action when idioms loading fails
class LoadIdiomsFailureAction {
  final String error;
  LoadIdiomsFailureAction(this.error);
}
