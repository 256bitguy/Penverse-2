// lib/features/subjects/topic/redux/topic_reducer.dart

import 'topic_state.dart';
import 'topic_action.dart';

TopicState topicReducer(TopicState state, dynamic action) {
  if (action is LoadTopicsAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is LoadTopicsSuccessAction) {
    return state.copyWith(
      isLoading: false,
      topics: action.topics ?? [],
      error: null,
    );
  } else if (action is LoadTopicsFailureAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }
  return state;
}
