// notes_action.dart
import 'notes_state.dart';

/// Trigger fetching a single note
class FetchNoteByTopicIdAction {
  final String topicId;
  FetchNoteByTopicIdAction(this.topicId);
}

/// Successfully fetched note
class FetchNoteSuccessAction {
  final NoteModel note;
  FetchNoteSuccessAction(this.note);
}

/// Failed to fetch note
class FetchNoteFailureAction {
  final String error;
  FetchNoteFailureAction(this.error);
}

/// Clear state
class ClearNotesAction {}
