import 'package:redux/redux.dart';
import '../../../core/store/app_state.dart';
import 'upsc_state.dart';
import 'upsc_actions.dart';

class UpscAwarenessViewModel {
  final List<UpscAwarenessItem> items;
  final bool isLoading;
  final String? error;
  final void Function() loadUpscAwareness;

  UpscAwarenessViewModel({
    required this.items,
    required this.isLoading,
    required this.error,
    required this.loadUpscAwareness,
  });

  factory UpscAwarenessViewModel.fromStore(Store<AppState> store) {
    return UpscAwarenessViewModel(
      items: store.state.upscAwarenessState.items,
      isLoading: store.state.upscAwarenessState.isLoading,
      error: store.state.upscAwarenessState.error,
      loadUpscAwareness: () {
        store.dispatch(LoadUpscAwarenessAction());
      },
    );
  }
}
