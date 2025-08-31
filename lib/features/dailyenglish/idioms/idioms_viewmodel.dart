import 'package:redux/redux.dart';
import '../../../core/store/app_state.dart';
import 'idioms_state.dart';
import 'idioms_actions.dart';

class IdiomsViewModel {
  final List<IdiomItem> items;
  final bool isLoading;
  final String? error;
  final void Function() loadIdioms;

  IdiomsViewModel({
    required this.items,
    required this.isLoading,
    required this.error,
    required this.loadIdioms,
  });

  factory IdiomsViewModel.fromStore(Store<AppState> store) {
    return IdiomsViewModel(
      items: store.state.idiomsState.items,
      isLoading: store.state.idiomsState.isLoading,
      error: store.state.idiomsState.error,
      loadIdioms: () {
        store.dispatch(LoadIdiomsAction());
      },
    );
  }
}
