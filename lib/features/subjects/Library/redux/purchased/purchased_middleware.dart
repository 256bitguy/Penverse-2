import 'package:penverse/core/store/app_state.dart';
import 'package:redux/redux.dart';
import 'purchased_actions.dart';
import 'purchased_services.dart';

List<Middleware<AppState>> createPurchasedMiddleware(PurchasedService service) {
  return [
    TypedMiddleware<AppState, PurchasedBooksAction>(
      _purchasedBooks(service),
    ),
  ];
}

Middleware<AppState> _purchasedBooks(PurchasedService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is PurchasedBooksAction) {
      try {
      print(
          "Middleware: Initiating search for purchased books for userId: ");
      final response = await service.purchasedBooks(
        
      );

      print("Middleware: Search successful, dispatching success action.");
      store.dispatch(PurchasedBooksSuccessAction(
        results: response['books'],
        totalResults: response['totalResults'],
        totalPages: response['totalPages'],
        currentPage: response['currentPage'],
      ));
    } catch (e) {
      next(PurchasedBooksFailedAction(e.toString()));
    }
    } else {
      next(action);
    }
    next(action);

    
  };
}
