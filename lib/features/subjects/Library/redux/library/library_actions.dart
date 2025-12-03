class GetLibraryAction {}

class GetLibrarySuccessAction {
  final String libraryName; // change to your Library Model if needed
  final String libraryId; // change to your Library Model if needed

  GetLibrarySuccessAction({
    required this.libraryName,
    required this.libraryId,
  });
}

class GetLibraryFailedAction {
  final String error;
  GetLibraryFailedAction(this.error);
}

/////////////////////---------------------
class EditLibraryNameAction {
  final String newName;
  final String libraryId;
  EditLibraryNameAction(this.newName, this.libraryId);
}

class EditLibraryNameSuccessAction {
  final String updatedName;

  EditLibraryNameSuccessAction(this.updatedName);
}

class EditLibraryNameFailedAction {
  final String error;

  EditLibraryNameFailedAction(this.error);
}
