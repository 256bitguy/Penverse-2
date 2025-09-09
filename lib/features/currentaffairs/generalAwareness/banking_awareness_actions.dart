import 'banking_awareness_state.dart';

class LoadBankingAwarenessAction {}
class FetchAwarenessByTopicIdAction {
    final String topicId;
  FetchAwarenessByTopicIdAction(this.topicId);
}
 

class LoadBankingAwarenessSuccessAction {
  final List<BankingAwarenessItem> items; // ✅ FIXED TYPE
  LoadBankingAwarenessSuccessAction(this.items);
}

class LoadBankingAwarenessFailureAction {
  final String error;
  LoadBankingAwarenessFailureAction(this.error);
}
