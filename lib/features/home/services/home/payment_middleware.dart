import 'package:redux/redux.dart';
import 'payment_actions.dart';
import 'payment_services.dart';
import '../../../../core/store/app_state.dart';

List<Middleware<AppState>> createPaymentMiddleware(PaymentService service) {
  return [
    TypedMiddleware<AppState, PaymentAction>(
      _payment(service),
    ),
  ];
}

Middleware<AppState> _payment(PaymentService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is PaymentAction) {
      next(action);

      try {
        final response = await service.processPayment(bookId: action.bookId);

        store.dispatch(PaymentSuccessAction(isPaid: response['isPaid']));
      } catch (e) {
        print("Middleware: Payment failed: $e");
        store.dispatch(PaymentFailedAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}
