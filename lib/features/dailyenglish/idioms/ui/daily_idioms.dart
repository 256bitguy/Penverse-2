import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/store/app_state.dart';
import '../idioms_viewmodel.dart'; // ✅ your idioms viewmodel
import '../../../entrypoint/entrypoint_ui.dart';
import 'examples.dart'; // ✅ your IdiomExamplePage

class DailyIdiomsScreen extends StatefulWidget {
  final String? topicId;
  const DailyIdiomsScreen({super.key, required this.topicId});

  @override
  State<DailyIdiomsScreen> createState() => _DailyIdiomsScreenState();
}

class _DailyIdiomsScreenState extends State<DailyIdiomsScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);

    // Load idioms once widget is mounted
    if (widget.topicId == null) {
      Future.microtask(() {
        final store = StoreProvider.of<AppState>(context, listen: false);
        final vm = IdiomsViewModel.fromStore(store);

        vm.loadIdioms();
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, IdiomsViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => IdiomsViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.items.isEmpty) {
          // Check if there's an error message
          if (vm.error != null && vm.error!.isNotEmpty) {
            return Scaffold(
              body: Center(child: Text(vm.error!)),
            );
          }

          // Otherwise, show empty state
          return const Scaffold(
            body: Center(child: Text('No items available')),
          );
        }

        final screenSize = MediaQuery.of(context).size;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const EntryPointUI()),
                );
              },
            ),
            title: const Text(
              "Daily Idioms",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              // Index indicator
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "${currentIndex + 1}/${vm.items.length}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: vm.items.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final idiom = vm.items[index];
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              idiom.imageUrl,
                              height: screenSize.height / 2,
                              width: screenSize.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Idiom
                          Text(
                            idiom.idiom,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Meaning
                          Text(
                            idiom.meaning,
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // English explanation
                          Text(
                            idiom.englishExplanation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Hindi explanation
                          Text(
                            idiom.hindiExplanation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Button -> Idiom Examples
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => IdiomExamplePage(
                                      examples: idiom.examples),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1F1F5D),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: const Text("Examples"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
