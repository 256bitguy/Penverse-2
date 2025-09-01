import 'banking_awareness_state.dart';

class LoadBankingAwarenessAction {}

class LoadBankingAwarenessSuccessAction {
  final List<BankingAwarenessItem> items; // ✅ FIXED TYPE
  LoadBankingAwarenessSuccessAction(this.items);
}

class LoadBankingAwarenessFailureAction {
  final String error;
  LoadBankingAwarenessFailureAction(this.error);
}
