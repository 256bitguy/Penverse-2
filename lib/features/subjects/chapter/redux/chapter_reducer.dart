import './chapter_actions.dart';
import './chapter_state.dart';

ChapterState chapterReducer(ChapterState state, dynamic action) {
  if (action is LoadChaptersAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is LoadChaptersSuccessAction) {
    return state.copyWith(isLoading: false, chapters: action.chapters, error: null);
  } else if (action is LoadChaptersFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  }

  return state;
}
