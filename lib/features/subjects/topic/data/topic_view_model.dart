// lib/features/subjects/topic/data/topic_view_model.dart

import 'package:redux/redux.dart';
import '../../../../core/store/app_state.dart';
import '../redux/topic_state.dart';

class TopicsViewModel {
  final bool isLoading;
  final List<Topic> topics;
  final String? error;

  TopicsViewModel({
    required this.isLoading,
    required this.topics,
    this.error,
  });

  /// Map Redux state to ViewModel
  static TopicsViewModel fromStore(Store<AppState> store) {
    final state = store.state.topicState;
    return TopicsViewModel(
      isLoading: state.isLoading,
      topics: state.topics ?? [], // same type as Redux
      error: state.error,
    );
  }
}
