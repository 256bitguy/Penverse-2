import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:penverse/features/dailyenglish/vocabulary/ui/Quiz_page.dart';
import 'package:redux/redux.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/store/app_state.dart';
import 'antonyms.dart';
import 'synonyms.dart';
import '../vocab_viewmodel.dart';
import '../../../entrypoint/entrypoint_ui.dart';
import 'practise_word.dart';
import 'practise.dart'; // ✅ practice page
import '../models/VocabPractise.dart';

class DailyVocabScreen extends StatefulWidget {
  final String? topicId;
  const DailyVocabScreen({super.key, required this.topicId});

  @override
  State<DailyVocabScreen> createState() => _DailyVocabScreenState();
}

class _DailyVocabScreenState extends State<DailyVocabScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // ✅ key for sidebar

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);

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
        final screenSize = MediaQuery.of(context).size;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFF0D0D0D),
          drawer: _buildSidebar(vm), // ✅ Sidebar here
          appBar: AppBar(
            backgroundColor: const Color(0xFF121212),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white70),
              onPressed: () =>
                  _scaffoldKey.currentState?.openDrawer(), // ✅ toggle drawer
            ),
            title: const Text(
              "Daily English",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white70),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Colors.tealAccent,
                            onPrimary: Colors.black,
                            surface: Color(0xFF1E1E1E),
                            onSurface: Colors.white,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    final store =
                        StoreProvider.of<AppState>(context, listen: false);
                    VocabViewModel.fromStore(store).loadVocabByDate(pickedDate);
                  }
                },
              ),
            ],
          ),
          body: vm.items.isEmpty
              ? const Center(
                  child: Text(
                    "No vocab found for Today",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "${currentIndex + 1}/${vm.items.length}",
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 16),
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    vocab.imageUrl,
                                    height: screenSize.height * 0.55,
                                    width: screenSize.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  vocab.word,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  vocab.partOfSpeech,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A1A1A),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: vocab.explanations
                                        .map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.meaning,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  e.englishExplanation,
                                                  style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  e.hindiExplanation,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => SynonymPage(
                                                synonyms: vocab.synonyms,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF2D2D2D),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Synonyms",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => AntonymPage(
                                                antonyms: vocab.antonyms,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF3A3A3A),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Antonyms",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      final currentVocab =
                                          vm.items[currentIndex];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SynAntQuizScreen(
                                              vocab: currentVocab),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.tealAccent[700],
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(Icons.edit,
                                        color: Colors.black87),
                                    label: const Text(
                                      "Practice Quiz",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      final currentVocab =
                                          vm.items[currentIndex];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => VocabPracticeScreen(
                                              vocabItem: currentVocab),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.tealAccent[700],
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(Icons.edit,
                                        color: Colors.black87),
                                    label: const Text(
                                      "Check Learning",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
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

  /// ✅ Sidebar Drawer Widget
  Widget _buildSidebar(VocabViewModel vm) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF121212)),
            child: Center(
              child: Text(
                "Today's Words",
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ✅ Vocabulary list
          Expanded(
            child: ListView.builder(
              itemCount: vm.items.length,
              itemBuilder: (context, index) {
                final word = vm.items[index].word;
                final isSelected = index == currentIndex;
                return ListTile(
                  title: Text(
                    word,
                    style: TextStyle(
                      color: isSelected ? Colors.tealAccent : Colors.white70,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                    _pageController.jumpToPage(index);
                    Navigator.pop(context); // close drawer
                  },
                );
              },
            ),
          ),

          const Divider(color: Colors.white24, height: 1),

          // ✅ Practice Button (bottom)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.school, color: Colors.black),
                label: const Text(
                  "Start Practice",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[700],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  final List<VocabPractice> vocabObjects = vm.items.map((item) {
                    return VocabPractice(
                        word: item.word,
                        imageUrl: item.imageUrl,
                        meaning: item.explanations.isNotEmpty
                            ? item.explanations[0].meaning
                            : '');
                  }).toList();

                  Navigator.pop(context); // close drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VocabFillPracticeScreen(
                        vocabList: vocabObjects, // passing full vocab list
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
