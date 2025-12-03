import 'package:penverse/core/store/app_state.dart';
import 'package:redux/redux.dart';
import 'library_actions.dart';
import 'library_services.dart';

List<Middleware<AppState>> createLibraryMiddleware(LibraryService service) {
  return [
    TypedMiddleware<AppState, GetLibraryAction>(
      _library(service),
    ),
    TypedMiddleware<AppState, EditLibraryNameAction>(
      _editlibrary(service),
    ),
  ];
}

Middleware<AppState> _library(LibraryService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetLibraryAction) {
      try {
    
        final response = await service.getLibrary();

      
        store.dispatch(GetLibrarySuccessAction(
          libraryName: response['libraryName'],
          libraryId: response['libraryId'],
        ));
      } catch (e) {
        next(GetLibraryFailedAction(e.toString()));
      }
    } else {
      next(action);
    }
    next(action);
  };
}

Middleware<AppState> _editlibrary(LibraryService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is EditLibraryNameAction) {
      try {
        final response = await service.editLibrary(action.newName,action.libraryId);

        store.dispatch(EditLibraryNameSuccessAction(response["libraryName"]));
      } catch (e) {
        next(EditLibraryNameFailedAction(e.toString()));
      }
    } else {
      next(action);
    }
    next(action);
  };
}
