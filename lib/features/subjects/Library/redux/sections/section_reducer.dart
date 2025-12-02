// lib/features/sections/redux/section_reducer.dart

import 'section_state.dart';
import 'section_actions.dart';

SectionState sectionReducer(SectionState state, dynamic action) {
  if (action is LoadSectionsAction) {
    return state.copyWith(isLoading: true, error: null);

  } else if (action is LoadSectionsSuccessAction) {
    return state.copyWith(
      isLoading: false,
      sections: action.sections,
      error: null,
    );

  } else if (action is LoadSectionsFailureAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }

  return state;
}
