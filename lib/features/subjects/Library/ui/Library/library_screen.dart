import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/library/library_actions.dart';
import 'package:penverse/features/subjects/Library/redux/library/library_viewmodel.dart';

import '../../../../../core/constants/app_colors.dart';

import '../Sections/section_list.dart';
import '../Purchased/purchased.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int selectedTab = 0;
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // 👉 Auto-fetch as soon as Purchased Page appears
    Future.microtask(() {
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(GetLibraryAction());
    });
  }

  void _handleTabChange(int index) {
    setState(() => selectedTab = index);
  }

  void _openEditLibraryNameModal(LibraryViewModel vm) {
    _nameController.text = vm.libraryName ?? "";

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Library Name",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter new name",
                  hintStyle: GoogleFonts.poppins(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.08),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    vm.editLibrary(_nameController.text.trim(), vm.libraryId);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return StoreConnector<AppState, LibraryViewModel>(
      onInit: (store) => store.dispatch(GetLibraryAction()),
      converter: (store) => LibraryViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            elevation: 2,
            backgroundColor: AppColors.cardBackground,
            shadowColor: AppColors.cardBackground.withOpacity(0.4),
            title: Text(
              vm.libraryName ?? "My Library",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => _openEditLibraryNameModal(vm),
                icon: const Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),
          body: Column(
            children: [
              Row(
                children: [
                  _buildTabButton("Sections", 0, width / 2),
                  _buildTabButton("Purchased", 1, width / 2),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: IndexedStack(
                  index: selectedTab,
                  children: const [
                    SectionsWidget(),
                    PurchasedPage(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabButton(String label, int index, double width) {
    final bool isActive = selectedTab == index;

    return GestureDetector(
      onTap: () => _handleTabChange(index),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.cardBackground : Colors.transparent,
          border: isActive
              ? const Border(
                  bottom: BorderSide(color: Colors.tealAccent, width: 2),
                )
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isActive ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
