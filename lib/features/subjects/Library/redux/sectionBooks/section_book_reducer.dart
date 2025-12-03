import 'package:flutter/material.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_books_actions.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_books_state.dart';

SectionBooksState sectionBooksReducer(SectionBooksState state, dynamic action) {
  if (action is LoadBooksBySectionRequestAction) {
    // debugPrint("Reducer: LoadBooksBySectionRequestAction for sectionId=${action.sectionId}");

    return state.copyWith(
      isLoadingBySection: {
        ...state.isLoadingBySection,
        action.sectionId: true,
      },
      errorBySection: {
        ...state.errorBySection,
        action.sectionId: null,
      },
    );
  }

  if (action is LoadBooksBySectionSuccessAction) {
    // debugPrint("Reducer: LoadBooksBySectionSuccessAction for sectionId=${action.sectionId}");
    // debugPrint("Books loaded: ${action.books.map((b) => b.title).toList()}");

    return state.copyWith(
      booksBySection: {
        ...state.booksBySection,
        action.sectionId: action.books,
      },
      isLoadingBySection: {
        ...state.isLoadingBySection,
        action.sectionId: false,
      },
      errorBySection: {
        ...state.errorBySection,
        action.sectionId: null,
      },
    );
  }

  if (action is LoadBooksBySectionFailureAction) {
    // debugPrint("Reducer: LoadBooksBySectionFailureAction for sectionId=${action.sectionId}");
    // debugPrint("Error: ${action.error}");

    return state.copyWith(
      isLoadingBySection: {
        ...state.isLoadingBySection,
        action.sectionId: false,
      },
      errorBySection: {
        ...state.errorBySection,
        action.sectionId: action.error,
      },
    );
  }

  return state;
}
