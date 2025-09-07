import 'package:redux/redux.dart';

import '../redux/notes_state.dart';
import '../redux/notes_action.dart';
import '../../../../core/store/app_state.dart';

class NotesViewModel {
  final bool isLoading;
  final NoteModel? note;
  final String error;
  final Function(String topicId) fetchNote;

  NotesViewModel({
    required this.isLoading,
    required this.note,
    required this.error,
    required this.fetchNote,
  });

  static NotesViewModel fromStore(Store<AppState> store) {
    return NotesViewModel(
      isLoading: store.state.notesState.isLoading,
      note: store.state.notesState.note,
      error: store.state.notesState.error,
      fetchNote: (topicId) => store.dispatch(FetchNoteByTopicIdAction(topicId)),
    );
  }
}
