// lib/features/subjects/ui/subjects_view_model.dart
import 'package:penverse/core/store/app_state.dart';
import 'package:redux/redux.dart';
import '../redux/subject_state.dart';
import '../redux/subject_actions.dart';
import '../../book/redux/book_actions.dart';

class SubjectsViewModel {
  final bool isLoading;
  final List<Subject> subjects;
  final String? error;
  final Function() loadSubjects;
  final Function(String subjectId) loadBooksBySubject;

  SubjectsViewModel({
    required this.isLoading,
    required this.subjects,
    this.error,
    required this.loadSubjects,
    required this.loadBooksBySubject,
  });

  static SubjectsViewModel fromStore(Store<AppState> store) {
    return SubjectsViewModel(
      isLoading: store.state.subjectState.isLoading,
      subjects: store.state.subjectState.subjects,
      error: store.state.subjectState.error,
      loadSubjects: () => {
        print("second"),
        store.dispatch(LoadSubjectsAction()),
      },
      loadBooksBySubject: (subjectId) {
        store.dispatch(LoadBooksBySubjectAction(subjectId));
      },
    );
  }
}
