import 'editorial_state.dart';

class LoadEditorialAction {}

class LoadEditorialByDateAction {
  final DateTime date; // this is the missing field
  LoadEditorialByDateAction(this.date);
}


class LoadEditorialSuccessAction {
  final List<EditorialItem> items;
  LoadEditorialSuccessAction(this.items);
}

class LoadEditorialFailureAction {
  final String error;
  LoadEditorialFailureAction(this.error);
}
 
 