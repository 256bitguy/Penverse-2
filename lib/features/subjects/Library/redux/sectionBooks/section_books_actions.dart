import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_model.dart';

class LoadBooksBySectionRequestAction {
  final String sectionId;
  LoadBooksBySectionRequestAction(this.sectionId);
}

class LoadBooksBySectionSuccessAction {
  final String sectionId;
  final List<SectionBook> books;
 

  LoadBooksBySectionSuccessAction({
    required this.sectionId,
    required this.books,
     
  });
}

class LoadBooksBySectionFailureAction {
  final String sectionId;
  final String error;

  LoadBooksBySectionFailureAction({
    required this.sectionId,
    required this.error,
  });
}
