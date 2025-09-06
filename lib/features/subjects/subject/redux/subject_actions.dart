// lib/features/subjects/redux/subject_actions.dart
import '../redux/subject_state.dart';

class LoadSubjectsAction {}

class LoadSubjectsSuccessAction {
  final List<Subject> subjects;
  LoadSubjectsSuccessAction(this.subjects);
}

class LoadSubjectsFailureAction {
  final String error;
  LoadSubjectsFailureAction(this.error);
}
