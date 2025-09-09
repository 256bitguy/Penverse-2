import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/store/app_state.dart';
import '../phrasal_verb_viewmodel.dart';
import '../../../entrypoint/entrypoint_ui.dart';
import 'examples.dart';

class DailyPhrasalVerbScreen extends StatefulWidget {
  final String? topicId;
  const DailyPhrasalVerbScreen({super.key, required this.topicId});

  @override
  State<DailyPhrasalVerbScreen> createState() => _DailyPhrasalVerbScreenState();
}

class _DailyPhrasalVerbScreenState extends State<DailyPhrasalVerbScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);

    if (widget.topicId == null) {
      Future.microtask(() {
        final store = StoreProvider.of<AppState>(context, listen: false);
        final vm = PhrasalVerbsViewModel.fromStore(store);
        vm.loadPhrasalVerbs();
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
    return StoreConnector<AppState, PhrasalVerbsViewModel>(
      distinct: true,
      converter: (Store<AppState> store) =>
          PhrasalVerbsViewModel.fromStore(store),
      builder: (context, vm) {
        // Handle empty state and errors
        if (vm.items.isEmpty) {
          if (vm.error != null && vm.error!.isNotEmpty) {
            return Scaffold(
              body: Center(child: Text(vm.error!)),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
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
              "Daily Phrasal Verbs",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // TODO: Search feature
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Page indicator
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "${currentIndex + 1}/${vm.items.length}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              // Scrollable content
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
                    final phrasal = vm.items[index];
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
                              phrasal.imageUrl,
                              height: screenSize.height / 2,
                              width: screenSize.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Phrasal Verb Title
                          Text(
                            phrasal.phrasalVerb,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Meaning
                          Text(
                            phrasal.meaning,
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // English explanation
                          Text(
                            phrasal.englishExplanation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Hindi explanation
                          Text(
                            phrasal.hindiExplanation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Button pinned to bottom
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final phrasal = vm.items[currentIndex];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PhrasalVerbExamplePage(examples: phrasal.examples),
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
                  child: const Text(
                    "View Examples",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
