// lib/features/chapter/redux/chapter_reducer.dart
import 'chapter_state.dart';
import 'chapter_actions.dart';

ChapterState chapterReducer(ChapterState state, dynamic action) {
  if (action is LoadChaptersAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is LoadChaptersSuccessAction) {
    return state.copyWith(
      isLoading: false,
      chapters: action.chapters ?? [], // List<Chapter>
      error: null,
    );
  } else if (action is LoadChaptersFailureAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }
  return state;
}
