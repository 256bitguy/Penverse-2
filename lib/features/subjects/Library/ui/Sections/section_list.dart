import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import 'section_screen.dart';

class SectionsWidget extends StatefulWidget {
  const SectionsWidget({super.key});

  @override
  State<SectionsWidget> createState() => _SectionsWidgetState();
}

class _SectionsWidgetState extends State<SectionsWidget> {
  final TextEditingController _sectionController = TextEditingController();

  List<Map<String, dynamic>> dummySections = [
    {"name": "Fiction", "books": 12}
  ];

  void _openAddSectionModal() {
    showModalBottomSheet(
      backgroundColor: AppColors.cardBackground,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add New Section",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _sectionController,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter section name",
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
                  if (_sectionController.text.trim().isEmpty) return;

                  setState(() {
                    dummySections.add({
                      "name": _sectionController.text.trim(),
                      "books": 0,
                    });
                  });

                  _sectionController.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  "Add Section",
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
    return Stack(
      children: [
        // Section list
        ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 90),
          itemCount: dummySections.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final sec = dummySections[index];

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  sec["name"],
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                subtitle: Text(
                  "${sec["books"]} Books",
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SectionScreen(
                        sectionId: "12",
                        sectionName: sec["name"],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),

        // Small floating add button (bottom-left)
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.tealAccent,
            onPressed: _openAddSectionModal,
            child: const Icon(Icons.add, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
