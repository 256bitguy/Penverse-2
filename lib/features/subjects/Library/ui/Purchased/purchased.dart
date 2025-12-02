import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:penverse/features/subjects/Library/redux/purchased/purchased_actions.dart';
import 'package:penverse/features/subjects/Library/redux/purchased/purchased_viewmodel.dart';
import 'package:penverse/features/subjects/Library/ui/Purchased/book/book_display_card.dart';
import '../../../../../core/store/app_state.dart';
import 'package:penverse/features/home/presentation/widgets/book_card.dart';

class PurchasedPage extends StatefulWidget {
  const PurchasedPage({super.key});

  @override
  State<PurchasedPage> createState() => _PurchasedPageState();
}

class _PurchasedPageState extends State<PurchasedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // 👉 Auto-fetch as soon as Purchased Page appears
    Future.microtask(() {
      print("PurchasedPage initState: Dispatching PurchasedBooksAction");
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(PurchasedBooksAction());
      print("PurchasedPage initState: Dispatched PurchasedBooksAction");
    });

    // 👉 Pagination logic
    _scrollController.addListener(() {
      final store = StoreProvider.of<AppState>(context);
      final vm = store.state.purchasedBookState;

      final isNearBottom = _scrollController.position.maxScrollExtent -
              _scrollController.offset <
          300;

      if (!vm.isLoading && vm.currentPage < vm.totalPages && isNearBottom) {
        store.dispatch(PurchasedBooksAction(page: vm.currentPage + 1));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PurchasedViewmodel>(
      converter: (store) => PurchasedViewmodel.fromStore(store),
      builder: (context, vm) {
        print(
            "PurchasedPage build -> isLoading=${vm.isLoading}, results=${vm.results.length}, total=${vm.totalResults}");

        // 👉 Show loader only when loading FIRST page
        if (vm.isLoading && vm.results.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // 👉 No data
        if (vm.results.isEmpty) {
          return const Center(
            child: Text(
              "No.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          );
        }

        // 👉 Book list
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(2),
          itemCount: vm.results.length + (vm.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            // 👉 Show bottom loader when loading next page
            if (index >= vm.results.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final book = vm.results[index];
            return PurchasedBookCard(
              book: book,
              
              // onRead: () {
              //   // Navigate to reader page (you will implement this)
              //   print("Open book: ${book["book"]["_id"]}");
              // },
            ) ;
          },
        );
      },
    );
  }
}
