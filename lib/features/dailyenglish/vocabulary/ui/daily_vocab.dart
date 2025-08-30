import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/store/app_state.dart';
import '../../../currentaffairs/presentation/screens/synonyms.dart';
import '../../../currentaffairs/presentation/screens/antonyms.dart';
import '../vocab_viewmodel.dart'; // ✅ your viewmodel

class DailyVocabScreen extends StatefulWidget {
  const DailyVocabScreen({super.key});

  @override
  State<DailyVocabScreen> createState() => _DailyVocabScreenState();
}

class _DailyVocabScreenState extends State<DailyVocabScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);

    // Load vocab once widget is mounted
    Future.microtask(() {
      final store = StoreProvider.of<AppState>(context, listen: false);
      final vm = VocabViewModel.fromStore(store);
      vm.loadVocab();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VocabViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => VocabViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.items.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No vocab found")),
          );
        }

        final screenSize = MediaQuery.of(context).size;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            title: const Text(
              "Penverse",
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
                    final vocab = vm.items[index];
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
                              vocab.imageUrl,
                              height: screenSize.height / 2,
                              width: screenSize.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Word
                          Text(
                            vocab.word,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Part of speech
                          Text(
                            vocab.partOfSpeech,
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // English explanation
                          Text(
                            vocab.englishExplanation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Hindi explanation
                          Text(
                            vocab.hindiExplanation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Synonym + Antonym Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SynonymPage(
                                              // synonyms: vocab.synonyms
                                              )),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5E5EBC),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  child: const Text("Synonyms"),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AntonymPage(
                                              // antonyms: vocab.antonyms
                                              )),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1F1F5D),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  child: const Text("Antonyms"),
                                ),
                              ),
                            ],
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
        );
      },
    );
  }
}
