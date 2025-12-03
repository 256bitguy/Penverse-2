import 'package:penverse/features/home/services/home/payment_actions.dart';
import 'package:redux/redux.dart';

import '../../../../core/store/app_state.dart';

class PaymentViewModel {
  final bool isProcessing;

  final String error;

  final Function(String bookId) payment;

  PaymentViewModel({
    required this.isProcessing,
    required this.error,
    required this.payment,
  });

  factory PaymentViewModel.fromStore(Store<AppState> store) {
    final state = store.state.paymentState;

    return PaymentViewModel(
      isProcessing: state.isProcessing,
      error: state.error,
      payment: (bookId) {
    
        store.dispatch(PaymentAction(bookId));
      },
    );
  }
}
