import 'package:penverse/core/models/book_model.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/purchased/purchased_actions.dart';
import 'package:redux/redux.dart';

class PurchasedViewmodel {
  final bool isLoading;
  final List<Book> results;
  final int totalResults;
  final String? error;
  final Function() fetchPurchasedBooks;

  PurchasedViewmodel({
    required this.isLoading,
    required this.results,
    required this.totalResults,
     required this.error,
    required this.fetchPurchasedBooks,
  });

  factory PurchasedViewmodel.fromStore(Store<AppState> store) {
    final state = store.state.purchasedBookState;

    return PurchasedViewmodel(
      isLoading: state.isLoading,
      results: state.results,
      totalResults: state.totalResults,
      error: state.error,
      fetchPurchasedBooks: () {
        // store.dispatch(PurchasedBooksAction());
      },
    );
  }
}
