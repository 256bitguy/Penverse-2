import 'package:redux/redux.dart';
import 'library_state.dart';
import 'library_actions.dart';

final libraryReducer = combineReducers<LibraryState>([
  // GET LIBRARY
  TypedReducer<LibraryState, GetLibraryAction>(_onGetLibrary),
  TypedReducer<LibraryState, GetLibrarySuccessAction>(_onGetLibrarySuccess),
  TypedReducer<LibraryState, GetLibraryFailedAction>(_onGetLibraryFailed),

  // EDIT LIBRARY
  TypedReducer<LibraryState, EditLibraryNameAction>(_onEditLibrary),
  TypedReducer<LibraryState, EditLibraryNameSuccessAction>(_onEditLibrarySuccess),
  TypedReducer<LibraryState, EditLibraryNameFailedAction>(_onEditLibraryFailed),
]);

// ---------------------------
// GET LIBRARY HANDLERS
// ---------------------------

LibraryState _onGetLibrary(
    LibraryState state, GetLibraryAction action) {
  return state.copyWith(
    isLoading: true,
    error: '',
  );
}

LibraryState _onGetLibrarySuccess(
    LibraryState state, GetLibrarySuccessAction action) {
  return state.copyWith(
    isLoading: false,
    libraryName: action.libraryName,
    libraryId: action.libraryId,
    error: '',
  );
}

LibraryState _onGetLibraryFailed(
    LibraryState state, GetLibraryFailedAction action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

// ---------------------------
// EDIT LIBRARY HANDLERS
// ---------------------------

LibraryState _onEditLibrary(
    LibraryState state, EditLibraryNameAction action) {
  return state.copyWith(
    isLoading: true,
    error: '',
  );
}

LibraryState _onEditLibrarySuccess(
    LibraryState state, EditLibraryNameSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    libraryName: action.updatedName,
    error: '',
  );
}

LibraryState _onEditLibraryFailed(
    LibraryState state, EditLibraryNameFailedAction action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}
