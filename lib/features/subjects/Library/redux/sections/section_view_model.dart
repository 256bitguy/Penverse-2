import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_actions.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_model.dart';
 
import 'package:redux/redux.dart';

class SectionViewModel {
  final bool isLoadingSections;
  final List<Section> sections;
  // final Map<String, List<Book>> booksBySection;
  // final String? error;
  // final String? loadingBooksForSectionId;

  // Actions
  // final Function() loadSections;
  // final Function(String sectionId) loadBooksBySection;
  final Function({
    required String libraryId,
    required String name,
    String? picture,
    String? description,
  }) addSection;
  // final Function({
  //   required String sectionId,
  //   required Map<String, dynamic> data,
  // }) editSection;
  final Function({
    required String sectionId,
    required String bookId,
  }) addBookToSection;
  // final Function({
  //   required String sectionId,
  //   required String bookId,
  // }) removeBookFromSection;
  // final Function({
  //   required String sectionId,
  //   required String lastOpenedBookId,
  // }) reorderBooks;

  SectionViewModel({
    required this.isLoadingSections,
    required this.sections,
    // required this.booksBySection,
    // this.error,
    // this.loadingBooksForSectionId,
    // required this.loadSections,
    // required this.loadBooksBySection,
    required this.addSection,
    // required this.editSection,
    required this.addBookToSection,
    // required this.removeBookFromSection,
    // required this.reorderBooks,
  });

  static SectionViewModel fromStore(Store<AppState> store) {
    return SectionViewModel(
      isLoadingSections: store.state.sectionState.isLoadingSections,
      sections: store.state.sectionState.sections,
      // booksBySection: store.state.sectionState.booksBySection,
      // error: store.state.sectionState.error,
      // loadingBooksForSectionId: store.state.sectionState.loadingBooksForSectionId,

      // Action implementations
      // loadSections: () {
      //   store.dispatch(LoadSectionsAction(store.state.libraryState.libraryId));
      // },

      // loadBooksBySection: (sectionId) {
      //   store.dispatch(LoadBooksBySectionAction(sectionId));
      // },

      addSection: ({
        required String libraryId,
        required String name,
        String? picture,
        String? description,
      }) {
        store.dispatch(AddSectionAction(
          libraryId: libraryId,
          name: name,
          picture: picture,
          description: description,
        ));
      },

      // editSection: ({
      //   required String sectionId,
      //   required Map<String, dynamic> data,
      // }) {
      //   store.dispatch(EditSectionAction(
      //     sectionId: sectionId,
      //     data: data,
      //   ));
      // },

      addBookToSection: ({
        required String sectionId,
        required String bookId,
      }) {
        store.dispatch(AddBookToSectionAction(
          sectionId: sectionId,
          bookId: bookId,
        ));
      },

      // removeBookFromSection: ({
      //   required String sectionId,
      //   required String bookId,
      // }) {
      //   store.dispatch(RemoveBookFromSectionAction(
      //     sectionId: sectionId,
      //     bookId: bookId,
      //   ));
      // },

      // reorderBooks: ({
      //   required String sectionId,
      //   required String lastOpenedBookId,
      // }) {
      //   store.dispatch(ReorderBooksAction(
      //     sectionId: sectionId,
      //     lastOpenedBookId: lastOpenedBookId,
      //   ));
      // },
    );
  }
}
