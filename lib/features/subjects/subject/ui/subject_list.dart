// lib/features/subjects/ui/subjects_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/subject_state.dart';
import '../data/subject_view_model.dart';
import '../../book/ui/books_list.dart';
import '../../../../core/store/app_state.dart';

class SubjectsScreen extends StatefulWidget {
  final int id;
  const SubjectsScreen({super.key, required this.id});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Load subjects immediately when screen mounts
    Future.microtask(() {
      final store = StoreProvider.of<AppState>(context, listen: false);
      final vm = SubjectsViewModel.fromStore(store);
      vm.loadSubjects();
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  IconData getIcon(String iconValue) {
    switch (iconValue) {
      case "calculate":
        return Icons.calculate;
      case "science":
        return Icons.science;
      case "history":
        return Icons.history_edu;
      case "menu_book":
        return Icons.menu_book;
      default:
        return Icons.book;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SubjectsViewModel>(
      converter: (store) => SubjectsViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.error != null) {
          return Scaffold(
            body: Center(child: Text("Error: ${vm.error}")),
          );
        }

        // Filter subjects by search query
        final filteredSubjects = vm.subjects.where((subject) {
          return subject.name.toLowerCase().contains(_searchQuery);
        }).toList();

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Subjects",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  // TODO: navigate to profile
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search subjects...",
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),

              // 📚 Subjects List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSubjects.length,
                  itemBuilder: (context, index) {
                    final subject = filteredSubjects[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blue.shade200,
                            child: Icon(
                              getIcon(subject.iconValue),
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            subject.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            "${subject.totalBooks} Books",
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.white54,
                          ),
                          onTap: () {
                            if(subject.totalBooks != 0)
                            vm.loadBooksBySubject(subject.id);

                            // Navigate to books screen
                            Navigator.pushNamed(context, '/books');
                          },
                        ),
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
