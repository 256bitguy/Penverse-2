// lib/features/sections/ui/section_view_model.dart

import 'package:penverse/core/store/app_state.dart';
import 'package:redux/redux.dart';
import '../redux/section_state.dart';
import '../redux/section_actions.dart';
import '../../book/redux/book_actions.dart';

class SectionViewModel {
  final bool isLoading;
  final List<Section> sections;
  final String? error;
  final Function() loadSections;
  final Function(String sectionId) loadBooksBySection;

  SectionViewModel({
    required this.isLoading,
    required this.sections,
    this.error,
    required this.loadSections,
    required this.loadBooksBySection,
  });

  static SectionViewModel fromStore(Store<AppState> store) {
    return SectionViewModel(
      isLoading: store.state.sectionState.isLoading,
      sections: store.state.sectionState.sections,
      error: store.state.sectionState.error,

      loadSections: () {
        print("Loading Sections...");
        store.dispatch(LoadSectionsAction());
      },

      loadBooksBySection: (sectionId) {
        store.dispatch(LoadBooksBySectionAction(sectionId));
      },
    );
  }
}
