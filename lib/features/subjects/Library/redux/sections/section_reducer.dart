import 'package:redux/redux.dart';
import 'section_state.dart';
import 'section_actions.dart';

 
final sectionReducer = combineReducers<SectionState>([
 
 
   TypedReducer<SectionState, LoadSectionsAction>(_loadSections),
  TypedReducer<SectionState, LoadSectionsSuccessAction>(_loadSectionsSuccess),
  TypedReducer<SectionState, LoadSectionsFailureAction>(_loadSectionsFailed),
  TypedReducer<SectionState, AddSectionSuccessAction>(_addSectionSuccess),
  // TypedReducer<SectionState, EditSectionSuccessAction>(_editSectionSuccess),


   
  TypedReducer<SectionState, AddBookToSectionSuccessAction>(_addBookToSection),
  // TypedReducer<SectionState, RemoveBookFromSectionSuccessAction>(_removeBookFromSection),


  // TypedReducer<SectionState, ReorderBooksSuccessAction>(_reorderBooks),
]);

 
/// When loading begins
SectionState _loadSections(
    SectionState state, LoadSectionsAction action) {
  return state.copyWith(
    isLoadingSections: true,
    error: null,
  );
}

/// When API returns success
SectionState _loadSectionsSuccess(
    SectionState state, LoadSectionsSuccessAction action) {
  return state.copyWith(
    isLoadingSections: false,
    sections: action.sections,
    error: null,
  );
}

/// When error happens
SectionState _loadSectionsFailed(
    SectionState state, LoadSectionsFailureAction action) {
  return state.copyWith(
    isLoadingSections: false,
    error: action.error,
  );
}

SectionState _addSectionSuccess(
  SectionState state,
  AddSectionSuccessAction action,
) {
  return state.copyWith(
    sections: [...state.sections, action.newSection],
  );
}

// SectionState _editSectionSuccess(
//   SectionState state,
//   EditSectionSuccessAction action,
// ) {
//   final updatedList = state.sections.map((s) {
//     return s.id == action.updatedSection.id ? action.updatedSection : s;
//   }).toList();

//   return state.copyWith(sections: updatedList);
// }

/// ---------------------------------------------------------------------------
/// BOOK REDUCERS (Books inside specific section)
/// ---------------------------------------------------------------------------

 
SectionState _addBookToSection(
  SectionState state,
  AddBookToSectionSuccessAction action,
) {
  final updatedSection = action.section;
  final sectionId = updatedSection["_id"];
  final updatedBooks = updatedSection["books"] as List<dynamic>;

  final bookRefs = updatedBooks
      .map((id) => BookRef(id: id.toString()))
      .toList();

  return state.copyWith(
    booksBySection: {
      ...state.booksBySection,
      sectionId: bookRefs,
    },
  );
}



// SectionState _removeBookFromSection(
//   SectionState state,
//   RemoveBookFromSectionSuccessAction action,
// ) {
//   final currentBooks = [...(state.booksBySection[action.sectionId] ?? [])];

//   currentBooks.removeWhere((b) => b.id == action.bookId);

//   return state.copyWith(
//     booksBySection: {
//       ...state.booksBySection,
//       action.sectionId: currentBooks,
//     },
//   );
// }

/// ---------------------------------------------------------------------------
/// ORDER / REORDERING
/// ---------------------------------------------------------------------------

// SectionState _reorderBooks(
//   SectionState state,
//   ReorderBooksSuccessAction action,
// ) {
//   return state.copyWith(
//     booksBySection: {
//       ...state.booksBySection,
//       action.sectionId: action.updatedOrder,
//     },
//   );
// }
