import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_actions.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_service.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createSectionMiddleware(SectionService service) {
  return [
    TypedMiddleware<AppState, LoadSectionsAction>(_loadSections(service)),
    TypedMiddleware<AppState, AddSectionAction>(_addSection(service)),
    // TypedMiddleware<AppState, EditSectionAction>(_editSection(service)),
    // TypedMiddleware<AppState, LoadBooksBySectionAction>(_loadBooksBySection(service)),
    TypedMiddleware<AppState, AddBookToSectionAction>(
        _addBookToSection(service)),
    // TypedMiddleware<AppState, RemoveBookFromSectionAction>(_removeBookFromSection(service)),
    // TypedMiddleware<AppState, ReorderBooksAction>(_reorderBooks(service)),
  ];
}

//
// ─────────────────────────────────────────────
//   1. LOAD SECTIONS
// ─────────────────────────────────────────────
//
Middleware<AppState> _loadSections(SectionService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadSectionsAction) {
      next(action);
      try {
        // print(" 1section hi print nahi ho rha bhai");
        final sections = await service.getSections(action.libraryId);
        // print(sections[0]);
        store.dispatch(LoadSectionsSuccessAction(sections));
      } catch (e) {
        store.dispatch(LoadSectionsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

//
// ─────────────────────────────────────────────
//   2. ADD SECTION
// ─────────────────────────────────────────────
//
Middleware<AppState> _addSection(SectionService service) {
  return (store, action, next) async {
    if (action is AddSectionAction) {
      next(action); // forward action first

      try {
        // print("Middleware: calling service...");
        final section = await service.addSection(
          name: action.name,
          description: action.description,
          picture: action.picture,
          libraryId: action.libraryId,
        );

        // print("Middleware: service returned $section");

        store.dispatch(AddSectionSuccessAction(section));
      } catch (e) {
        // print("Middleware ERROR: $e");
        store.dispatch(AddSectionFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

//
// ─────────────────────────────────────────────
//   3. EDIT SECTION
// ─────────────────────────────────────────────
//
// Middleware<AppState> _editSection(SectionService service) {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     try {
//       final updatedSection = await service.editSection(
//         sectionId: action.sectionId,
//         newName: action.newName,
//       );

//       store.dispatch(EditSectionSuccessAction(updatedSection));
//     } catch (e) {
//       store.dispatch(EditSectionFailureAction(e.toString()));
//     }
//   };
// }

//
// ─────────────────────────────────────────────
//   4. LOAD BOOKS OF SECTION
// ─────────────────────────────────────────────
//
// Middleware<AppState> _loadBooksBySection(SectionService service) {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     try {
//       final books = await service.getBooksInSection(action.sectionId);

//       store.dispatch(LoadBooksBySectionSuccessAction(
//         action.sectionId,
//         books,
//       ));
//     } catch (e) {
//       store.dispatch(LoadBooksBySectionFailureAction(e.toString()));
//     }
//   };
// }

//
// ─────────────────────────────────────────────
//   5. ADD BOOK TO SECTION
// ─────────────────────────────────────────────
//
Middleware<AppState> _addBookToSection(SectionService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddBookToSectionAction) {
      try {
        final result = await service.addBookToSection(
          action.sectionId,
          action.bookId,
        );

        final updatedSection = result["section"]; // updated books list

        store.dispatch(
          AddBookToSectionSuccessAction(
            section: updatedSection,
            message: result["message"],
          ),
        );
      } catch (e) {
        store.dispatch(
          AddBookToSectionFailureAction(
             e.toString(),
          ),
        );
      }
    } else {
      next(action);
    }
  };
}


//
// ─────────────────────────────────────────────
//   6. REMOVE BOOK FROM SECTION
// ─────────────────────────────────────────────
//
// Middleware<AppState> _removeBookFromSection(SectionService service) {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     try {
//       final updated = await service.removeBookFromSection(
//         sectionId: action.sectionId,
//         bookId: action.bookId,
//       );

//       store.dispatch(RemoveBookFromSectionSuccessAction(
//         sectionId: action.sectionId,
//         updatedSection: updated,
//       ));
//     } catch (e) {
//       store.dispatch(RemoveBookFromSectionFailureAction(e.toString()));
//     }
//   };
// }

//
// ─────────────────────────────────────────────
//   7. REORDER BOOKS
// ─────────────────────────────────────────────
//
// Middleware<AppState> _reorderBooks(SectionService service) {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     try {
//       final updated = await service.reorderBooks(
//         sectionId: action.sectionId,
//         lastOpenedBookId: action.lastOpenedBookId,
//       );

//       store.dispatch(ReorderBooksSuccessAction(
//         sectionId: action.sectionId,
//         updatedSection: updated,
//       ));
//     } catch (e) {
//       store.dispatch(ReorderBooksFailureAction(e.toString()));
//     }
//   };
// }
