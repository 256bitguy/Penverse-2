import 'banking_awareness_state.dart';

 
class FetchAwarenessByTopicIdAction {
    final String topicId;
  FetchAwarenessByTopicIdAction(this.topicId);
}
 class FetchAwarenessByDateAction {
  final DateTime date; // this is the missing field
  FetchAwarenessByDateAction(this.date);
}

class LoadBankingAwarenessSuccessAction {
  final List<BankingAwarenessItem> items; // ✅ FIXED TYPE
  LoadBankingAwarenessSuccessAction(this.items);
}

class LoadBankingAwarenessFailureAction {
  final String error;
  LoadBankingAwarenessFailureAction(this.error);
}
