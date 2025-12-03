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
     
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(PurchasedBooksAction());
 
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
 @override
Widget build(BuildContext context) {
  return StoreConnector<AppState, PurchasedViewmodel>(
    converter: (store) => PurchasedViewmodel.fromStore(store),
    builder: (context, vm) {
      final bg = Theme.of(context).scaffoldBackgroundColor;

      // FIRST LOAD SHIMMER / LOADER
      if (vm.isLoading && vm.results.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // EMPTY STATE
      if (vm.results.isEmpty) {
        return const Center(
          child: Text(
            "No purchased books.",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        );
      }

      // LIST
      return ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.zero, // 💥 no padding like WhatsApp
        itemCount: vm.results.length + (vm.isLoading ? 1 : 0),
        separatorBuilder: (_, __) => const Divider(
          color: Colors.white12,
          height: 1,
        ),
        itemBuilder: (context, index) {
          // bottom loader during pagination
          if (index >= vm.results.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final book = vm.results[index];

          return PurchasedBookCard(book:book);
        },
      );
    },
  );
}



}
