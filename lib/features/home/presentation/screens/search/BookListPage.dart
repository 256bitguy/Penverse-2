import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:penverse/features/home/presentation/widgets/book_card.dart';
import '../../../../../core/constants/app_colors.dart';

import '../../../services/search/search_viewmodel.dart';

import '../../../../../core/store/app_state.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({super.key});

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String lastQuery = "";
  Timer? _debounce; // <-- ADD THIS

  @override
  void dispose() {
    _debounce?.cancel(); // <-- IMPORTANT
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchViewModel>(
      converter: (store) => SearchViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: AppColors.cardBackground,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: AppColors.scaffoldBackground,
              elevation: 1,
              automaticallyImplyLeading: false,
              title: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(31, 232, 224, 224),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (text) {
                    if (_debounce?.isActive ?? false) {
                      _debounce?.cancel();
                    }

                    _debounce = Timer(const Duration(milliseconds: 800), () {
                      if (text.trim().isEmpty) return;

                      if (text != lastQuery) {
                        lastQuery = text;
                        vm.search(text);
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    hintText: 'Search Books, Authors, courses, exams...',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(137, 237, 233, 233)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          // BODY
          body: _buildBody(vm),
        );
      },
    );
  }

  Widget _buildBody(SearchViewModel vm) {
    print(vm.results.length ?? "no results");
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.totalResults == 0) {
      return const Center(
        child: Text(
          "Search something...",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: vm.totalResults,
      padding: const EdgeInsets.all(2),
      itemBuilder: (context, index) {
        final book = vm.results[index];

        return BookCard(book: book);
      },
    );
  }
}
