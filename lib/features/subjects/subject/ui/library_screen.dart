import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

// IMPORT BOTH WIDGETS
import 'section_list.dart';
import 'purchased.dart';

class LibraryScreen extends StatefulWidget {
  final String title; // Comes from backend
  const LibraryScreen({super.key, this.title = "My Library"});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int selectedTab = 0; // 0 = Sections, 1 = Purchased

  late String libraryName;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    libraryName = widget.title;
  }

  void _openEditLibraryNameModal() {
    _nameController.text = libraryName;

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
                    setState(() {
                      libraryName = _nameController.text.trim();
                    });
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

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: AppBar(
        elevation: 4,
        backgroundColor: AppColors.cardBackground,
        shadowColor: AppColors.cardBackground.withOpacity(0.4),
        title: Text(
          libraryName,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: _openEditLibraryNameModal,
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 14),

          // ===========================
          //        TAB BAR
          // ===========================
          Row(
            children: [
              _buildTabButton("Sections", 0, width / 2),
              _buildTabButton("Purchased", 1, width / 2),
            ],
          ),

          const SizedBox(height: 16),

          // ===========================
          //     CURRENT TAB VIEW
          // ===========================
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedTab == 0
                  ? const SectionsWidget()
                  : const PurchasedWidget(),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  //                TAB BUTTON WIDGET
  // =======================================================
  Widget _buildTabButton(String label, int index, double width) {
    final bool isActive = selectedTab == index;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.cardBackground : Colors.transparent,
          border: isActive
              ? Border(
                  bottom: BorderSide(
                    color: Colors.tealAccent,
                    width: 2,
                  ),
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
