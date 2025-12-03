import 'package:redux/redux.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/library/library_actions.dart';
import 'package:penverse/features/subjects/Library/redux/library/library_state.dart';

class LibraryViewModel {
  final bool isLoading;
  final String libraryName;
  final String libraryId;
  final String? error;

  final Function() fetchLibrary;
  final Function(String newName , String libraryId) editLibrary;

  LibraryViewModel({
    required this.isLoading,
    required this.libraryName,
    required this.libraryId,
    required this.error,
    required this.fetchLibrary,
    required this.editLibrary,
  });

  factory LibraryViewModel.fromStore(Store<AppState> store) {
    final state = store.state.libraryState;
  
    return LibraryViewModel(
      isLoading: state.isLoading,
      libraryName: state.libraryName,
      libraryId: state.libraryId ?? "1",
      error: state.error,

      /// ACTION: Fetch Library
      fetchLibrary: () {
        store.dispatch(GetLibraryAction());
      },

      /// ACTION: Edit Library Name
      editLibrary: (String newName, String libraryId) {
        store.dispatch(EditLibraryNameAction(newName,libraryId));
      },
    );
  }
}
