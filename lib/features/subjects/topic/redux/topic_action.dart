// lib/features/subjects/topic/redux/topic_actions.dart

import 'topic_state.dart';

/// ===============================
/// TOPIC ACTIONS
/// ===============================

/// Action to start loading topics
class LoadTopicsAction {}

/// Action dispatched when topics are successfully loaded
class LoadTopicsSuccessAction {
  final List<Topic> topics;
  LoadTopicsSuccessAction(this.topics);
}

/// Action dispatched when there is an error loading topics
class LoadTopicsFailureAction {
  final String error;
  LoadTopicsFailureAction(this.error);
}

/// Action to load topics by chapter
class LoadTopicsByChapterAction {
  final String chapterId;
  LoadTopicsByChapterAction(this.chapterId);
}
