import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/store/app_state.dart';
import 'details.dart';
import '../banking_awareness_viewmodel.dart';

class DailyNewsScreen extends StatefulWidget {
  const DailyNewsScreen({super.key});

  @override
  State<DailyNewsScreen> createState() => _DailyNewsScreenState();
}

class _DailyNewsScreenState extends State<DailyNewsScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);

    // load news from store
    Future.microtask(() {
      final store = StoreProvider.of<AppState>(context, listen: false);
      final vm = BankingAwarenessViewModel.fromStore(store);
      vm.loadBankingAwareness();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return StoreConnector<AppState, BankingAwarenessViewModel>(
      distinct: true,
      converter: (Store<AppState> store) =>
          BankingAwarenessViewModel.fromStore(store),
      builder: (context, vm) {
        print(vm.items[0].title);

        if (vm.items.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 0,
            title: const Text(
              "Daily Awareness",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Date
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    vm.items[currentIndex].date,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ),

                // Index indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "${currentIndex + 1}/${vm.items.length}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),

                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: vm.items.length,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                vm.items[currentIndex].imageUrl,
                                height: screenSize.height / 2,
                                width: screenSize.width / 1.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Title
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DailyScreen(
                                        newsItem: vm.items[currentIndex]),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  vm.items[currentIndex].title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
