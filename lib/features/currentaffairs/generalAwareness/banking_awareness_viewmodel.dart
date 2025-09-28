import 'package:redux/redux.dart';
import '../../../core/store/app_state.dart';
import 'banking_awareness_state.dart';
import 'banking_awareness_actions.dart';

class BankingAwarenessViewModel {
  final List<BankingAwarenessItem> items;
  final bool isLoading;
  final String? error;
 
  final void Function(DateTime date) loadEditorialByDate;

  BankingAwarenessViewModel({
    required this.items,
    required this.isLoading,
    required this.error,
    
    required this.loadEditorialByDate,
  });

  factory BankingAwarenessViewModel.fromStore(Store<AppState> store) {
    return BankingAwarenessViewModel(
      items: store.state.bankingAwarenessState.items,
      isLoading: store.state.bankingAwarenessState.isLoading,
      error: store.state.bankingAwarenessState.error,
      
       loadEditorialByDate: (DateTime date) {
         print("Loading awareness for date: $date");
        store.dispatch(FetchAwarenessByDateAction(date));
      },
    );
  }
}
