import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import '../redux/subject_state.dart';
import '../data/subject_view_model.dart';
import '../../book/ui/books_list.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/constants/app_colors.dart'; // Make sure this exists

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
            backgroundColor: AppColors.scaffoldBackground,
            body: Center(
              child: CircularProgressIndicator(color: Colors.tealAccent),
            ),
          );
        }

        if (vm.error != null) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            body: Center(
              child: Text(
                "Error: ${vm.error}",
                style: GoogleFonts.poppins(color: Colors.redAccent),
              ),
            ),
          );
        }

        // Filter subjects by search query
        final filteredSubjects = vm.subjects.where((subject) {
          return subject.name.toLowerCase().contains(_searchQuery);
        }).toList();

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            elevation: 4,
            backgroundColor: AppColors.cardBackground,
            shadowColor: AppColors.cardBackground.withOpacity(0.4),
            title: Text(
              "Subjects",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.05),
                        Colors.white.withOpacity(0.1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border:
                        Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.tealAccent),
                      hintText: "Search subjects...",
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),

              // 📚 Subjects List
              Expanded(
                child: filteredSubjects.isEmpty
                    ? Center(
                        child: Text(
                          "No subjects found",
                          style: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredSubjects.length,
                        itemBuilder: (context, index) {
                          final subject = filteredSubjects[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                              
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                               
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      Colors.tealAccent.withOpacity(0.3),
                                  child: Icon(
                                    getIcon(subject.iconValue),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                title: Text(
                                  subject.name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                subtitle: Text(
                                  "${subject.totalBooks} Books",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.white54,
                                ),
                                onTap: () {
                                  if (subject.totalBooks != 0) {
                                    vm.loadBooksBySubject(subject.id);
                                  }
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
