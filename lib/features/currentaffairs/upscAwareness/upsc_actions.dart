import 'upsc_state.dart';

class LoadUpscAwarenessAction {}

class LoadUpscAwarenessSuccessAction {
  final List<UpscAwarenessItem> items; // ✅ Updated type
  LoadUpscAwarenessSuccessAction(this.items);
}

class LoadUpscAwarenessFailureAction {
  final String error;
  LoadUpscAwarenessFailureAction(this.error);
}
