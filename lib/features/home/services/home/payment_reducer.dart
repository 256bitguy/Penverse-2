import 'package:redux/redux.dart';
import 'payment_state.dart';
import 'payment_actions.dart';
 

final paymentReducer = combineReducers<PaymentState>([
  TypedReducer<PaymentState, PaymentAction>(_onProcessing),
  TypedReducer<PaymentState, PaymentSuccessAction>(_onPaymentSuccess),
  TypedReducer<PaymentState, PaymentFailedAction>(_onPaymentFailed),
]);

PaymentState _onProcessing(PaymentState state, PaymentAction action) {
  return state.copyWith(
    isProcessing: true,
    error: '',
  );
}

PaymentState _onPaymentSuccess(
    PaymentState state, PaymentSuccessAction action) {
 
  return state.copyWith(
    isProcessing: false,
    error: '',
  );
}

PaymentState _onPaymentFailed(
    PaymentState state, PaymentFailedAction action) {
  return state.copyWith(
    isProcessing: false,
    error: action.error,
  );
}
