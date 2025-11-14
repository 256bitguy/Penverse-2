import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../data/chapter_view_model.dart';

class ChapterListScreen extends StatefulWidget {
  const ChapterListScreen({super.key});

  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  int _selectedChapterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChaptersViewModel>(
      converter: (store) => ChaptersViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.error != null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error: ${vm.error}",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (vm.chapters.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                "No chapters found",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        final selectedChapter = vm.chapters[_selectedChapterIndex];
        final progress = 20;

        return Scaffold(
          backgroundColor: const Color(0xFF0E0E0E),
          drawer: Drawer(
            backgroundColor: const Color(0xFF1A1A1A),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "📚 Chapters",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.chapters.length,
                      itemBuilder: (context, index) {
                        final chapter = vm.chapters[index];
                        final isSelected = index == _selectedChapterIndex;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? Colors.tealAccent.withOpacity(0.3)
                                : Colors.grey.shade700,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            chapter.title,
                            style: TextStyle(
                              color:
                                  isSelected ? Colors.tealAccent.withOpacity(0.3) : Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _selectedChapterIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: Text(
              selectedChapter.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  minHeight: 4,
                  backgroundColor: Colors.white10,
                  color:
                      progress >= 100 ? Colors.greenAccent : Colors.tealAccent.withOpacity(0.3),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    selectedChapter.description ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      height: 3,
                    ),
                  ),
                  // 🖼️ Chapter Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      // selectedChapter.imageUrl?.isNotEmpty == true
                      //     ? selectedChapter.imageUrl
                      //     :
                      'https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UY327_FMwebp_QL65_.jpg',
                      height: MediaQuery.of(context).size.height *
                          0.7, // 👈 80% of screen height
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 📘 Button to view topics
                  ElevatedButton.icon(
                    onPressed: () {
                      vm.loadTopicsByChapter(selectedChapter.id);
                      Navigator.pushNamed(context, '/topics');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.withOpacity(0.3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.menu_book, color: Colors.white),
                    label: const Text(
                      "View Topics",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 📝 Optional Chapter Description
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
