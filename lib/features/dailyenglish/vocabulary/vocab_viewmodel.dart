import 'package:redux/redux.dart';
import '../../../core/store/app_state.dart';
import 'vocab_state.dart';
import 'vocab_actions.dart';

class VocabViewModel {
  final List<VocabItem> items;
  final bool isLoading;
  final String? error;
  final void Function() loadVocab;
  final void Function(DateTime) loadVocabByDate;

  VocabViewModel({
    required this.items,
    required this.isLoading,
    required this.error,
    required this.loadVocab,
    required this.loadVocabByDate,
  });

  factory VocabViewModel.fromStore(Store<AppState> store) {
    return VocabViewModel(
      items: store.state.vocabState.items,
      isLoading: store.state.vocabState.isLoading,
      error: store.state.vocabState.error,
      loadVocab: () {
        store.dispatch(LoadVocabAction());
      },
      loadVocabByDate: (DateTime date) {
        print("done");
        store.dispatch(LoadVocabByDateAction(date));
      },
    );
  }
}
