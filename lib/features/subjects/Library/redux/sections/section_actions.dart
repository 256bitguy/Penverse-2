 
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_model.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_model.dart';
 

class LoadSectionsAction {
  final String libraryId;
  LoadSectionsAction(this.libraryId);
}

class LoadSectionsSuccessAction {
  final List<Section> sections;
  LoadSectionsSuccessAction(this.sections);
}

class LoadSectionsFailureAction {
  final String error;
  LoadSectionsFailureAction(this.error);
}

/// ----------------------
/// Add a New Section
/// ----------------------

class AddSectionAction {
  final String libraryId;
  final String name;
  final String? picture;
  final String? description;

  AddSectionAction({
    required this.libraryId,
    required this.name,
    this.picture,
    this.description,
  });
}

class AddSectionSuccessAction {
  final Section newSection;
  AddSectionSuccessAction(this.newSection);
}

class AddSectionFailureAction {
  final String error;
  AddSectionFailureAction(this.error);
}


// class EditSectionAction {
//   final String sectionId;
//   final Map<String, dynamic> data;
//   // Example: { "name": "Updated Name", "description": "New desc" }

//   EditSectionAction({
//     required this.sectionId,
//     required this.data,
//   });
// }

// class EditSectionSuccessAction {
//   final Section updatedSection;
//   EditSectionSuccessAction(this.updatedSection);
// }

// class EditSectionFailureAction {
//   final String error;
//   EditSectionFailureAction(this.error);
// }


  

 


class AddBookToSectionAction {
  final String sectionId;
  final String bookId;

  AddBookToSectionAction({
    required this.sectionId,
    required this.bookId,
  });
}

class AddBookToSectionSuccessAction {
  final Map<String, dynamic> section;
  final String message;

  AddBookToSectionSuccessAction({
    required this.section,
    required this.message,
  });
}


class AddBookToSectionFailureAction {
  final String error;
  AddBookToSectionFailureAction(this.error);
}

// class RemoveBookFromSectionAction {
//   final String sectionId;
//   final String bookId;

//   RemoveBookFromSectionAction({
//     required this.sectionId,
//     required this.bookId,
//   });
// }

// class RemoveBookFromSectionSuccessAction {
//   final String sectionId;
//   final String bookId;

//   RemoveBookFromSectionSuccessAction(this.sectionId, this.bookId);
// }

// class RemoveBookFromSectionFailureAction {
//   final String error;
//   RemoveBookFromSectionFailureAction(this.error);
// }


// class ReorderBooksAction {
//   final String sectionId;
//   final String lastOpenedBookId;

//   ReorderBooksAction({
//     required this.sectionId,
//     required this.lastOpenedBookId,
//   });
// }

// class ReorderBooksSuccessAction {
//   final String sectionId;
//   final List<Book> updatedOrder;

//   ReorderBooksSuccessAction(this.sectionId, this.updatedOrder);
// }

// class ReorderBooksFailureAction {
//   final String error;
//   ReorderBooksFailureAction(this.error);
// }
