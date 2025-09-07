import 'package:redux/redux.dart';
import '../../../core/store/app_state.dart';
import 'editorial_state.dart';
import 'editorial_actions.dart';

class EditorialViewModel {
  final List<EditorialItem> items;
  final bool isLoading;
  final String? error;
  final void Function() loadEditorial;
  final void Function(DateTime date) loadEditorialByDate;

  EditorialViewModel(
      {required this.items,
      required this.isLoading,
      required this.error,
      required this.loadEditorial,
      required this.loadEditorialByDate});

  factory EditorialViewModel.fromStore(Store<AppState> store) {
    return EditorialViewModel(
      items: store.state.editorialState.items,
      isLoading: store.state.editorialState.isLoading,
      error: store.state.editorialState.error,
      loadEditorial: () {
        store.dispatch(LoadEditorialAction());
      },
      loadEditorialByDate: (DateTime date) {
        print("done");
        store.dispatch(LoadEditorialByDateAction(date));
      },
    );
  }
}
