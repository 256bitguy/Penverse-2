// lib/features/subjects/chapter/data/chapter_view_model.dart

import 'package:redux/redux.dart';
import '../../../../core/store/app_state.dart';
import '../redux/chapter_state.dart';
import '../../topic/redux/topic_action.dart';

class ChaptersViewModel {
  final bool isLoading;
  final List<Chapter> chapters;
  final String? error;
  final Function(String bookId) loadTopicsByChapter;

  ChaptersViewModel(
      {required this.isLoading,
      required this.chapters,
      this.error,
      required this.loadTopicsByChapter});

  /// Map Redux state to ViewModel
  static ChaptersViewModel fromStore(Store<AppState> store) {
    final state = store.state.chapterState;
    return ChaptersViewModel(
        isLoading: state.isLoading,
        chapters: state.chapters ?? [], // same type as Redux
        error: state.error,
        loadTopicsByChapter: (bookId) {
          store.dispatch(LoadTopicsByChapterAction(bookId));
        });
  }
}
