// notes_reducer.dart
import 'notes_state.dart';
import 'notes_action.dart';

NotesState notesReducer(NotesState state, dynamic action) {
  if (action is FetchNoteByTopicIdAction) {
    return state.copyWith(isLoading: true, error: '');
  } else if (action is FetchNoteSuccessAction) {
    return state.copyWith(isLoading: false, note: action.note, error: '');
  } else if (action is FetchNoteFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  } else if (action is ClearNotesAction) {
    return NotesState.initial();
  }
  return state;
}
