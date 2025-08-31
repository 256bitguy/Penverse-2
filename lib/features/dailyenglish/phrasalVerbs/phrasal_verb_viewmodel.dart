import 'package:redux/redux.dart';
import '../../../core/store/app_state.dart';
import 'phrasal_verb_state.dart';
import 'phrasal_verbs_actions.dart';

class PhrasalVerbsViewModel {
  final List<PhrasalVerbItem> items;
  final bool isLoading;
  final String? error;
  final void Function() loadPhrasalVerbs;

  PhrasalVerbsViewModel({
    required this.items,
    required this.isLoading,
    required this.error,
    required this.loadPhrasalVerbs,
  });

  factory PhrasalVerbsViewModel.fromStore(Store<AppState> store) {
    return PhrasalVerbsViewModel(
      items: store.state.phrasalVerbsState.items,
      isLoading: store.state.phrasalVerbsState.isLoading,
      error: store.state.phrasalVerbsState.error,
      loadPhrasalVerbs: () {
        store.dispatch(LoadPhrasalVerbsAction());
      },
    );
  }
}
