import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_model.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_actions.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_view_model.dart';
import '../../../../../core/constants/app_colors.dart';
import 'section_screen.dart';
import 'helpers/section_input_card.dart';

class SectionsWidget extends StatefulWidget {
  const SectionsWidget({super.key});

  @override
  State<SectionsWidget> createState() => _SectionsWidgetState();
}

class _SectionsWidgetState extends State<SectionsWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final store = StoreProvider.of<AppState>(context);
      final libraryId = store.state.libraryState.libraryId;
      // print(libraryId);
      if (libraryId.isNotEmpty) {
        store.dispatch(LoadSectionsAction(libraryId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SectionViewModel>(
      converter: (store) => SectionViewModel.fromStore(store),
      builder: (context, vm) {
        final sections = vm.sections;
        // print(sections);
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground, // your background
          body: vm.isLoadingSections
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                )
              : sections.isEmpty
                  ? Center(
                      child: Text(
                        "No sections yet. Tap + to add.",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding:
                          EdgeInsets.zero, // 👈 No outer padding like WhatsApp
                      itemCount: sections.length,
                      separatorBuilder: (_, __) => Divider(
                        color: Colors.white12,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final sec = sections[index];
                        return _sectionTile(sec);
                      },
                    ),
          floatingActionButton: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.tealAccent,
            onPressed: () {
              final store = StoreProvider.of<AppState>(context);
              final libraryId = store.state.libraryState.libraryId;

              openAddSectionModal(
                context: context,
                libraryId: libraryId,
              );
            },
            child: const Icon(Icons.add, color: Colors.black),
          ),
        );
      },
    );
  }

  Widget _sectionTile(Section sec) {
    final name = sec.name;
    final desc = sec.description ?? "";
    final books = sec.books.length;
    final imageUrl = sec.picture;
    final sectionId = sec.id;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SectionScreen(
              sectionName: name,
              sectionId: sectionId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: (imageUrl != null && imageUrl.isNotEmpty)
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _initialsAvatar(name),
                      )
                    : _initialsAvatar(name),
              ),
            ),

            const SizedBox(width: 14),

            // Title + desc
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Books count badge (small)
            Text(
              "$books",
              style: GoogleFonts.poppins(
                color: Colors.tealAccent,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _initialsAvatar(String name) {
    final initials = name.trim().isEmpty
        ? "?"
        : name
            .split(" ")
            .map((e) => e.isNotEmpty ? e[0] : "")
            .take(2)
            .join()
            .toUpperCase();

    return Container(
      color: Colors.white12,
      alignment: Alignment.center,
      child: Text(initials,
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
