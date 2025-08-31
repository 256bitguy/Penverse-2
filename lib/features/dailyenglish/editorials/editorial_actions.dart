import 'editorial_state.dart';

class LoadEditorialAction {}

class LoadEditorialSuccessAction {
  final List<EditorialItem> items;
  LoadEditorialSuccessAction(this.items);
}

class LoadEditorialFailureAction {
  final String error;
  LoadEditorialFailureAction(this.error);
}
