// lib/features/subjects/redux/subject_reducer.dart
import 'subject_state.dart';
import 'subject_actions.dart';

SubjectState subjectReducer(SubjectState state, dynamic action) {
  if (action is LoadSubjectsAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is LoadSubjectsSuccessAction) {
    return state.copyWith(isLoading: false, subjects: action.subjects, error: null);
  } else if (action is LoadSubjectsFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  }
  return state;
}
