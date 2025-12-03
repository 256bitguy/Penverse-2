import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_model.dart';

class SectionBooksState {
  final Map<String, List<SectionBook>> booksBySection; // Key: sectionId
  final Map<String, bool> isLoadingBySection; // loading per section
  final Map<String, String?> errorBySection; // errors per section

  SectionBooksState({
    required this.booksBySection,
    required this.isLoadingBySection,
    required this.errorBySection,
  });

  factory SectionBooksState.initial() => SectionBooksState(
        booksBySection: {},
        isLoadingBySection: {},
        errorBySection: {},
      );

  SectionBooksState copyWith({
    Map<String, List<SectionBook>>? booksBySection,
    Map<String, bool>? isLoadingBySection,
    Map<String, String?>? errorBySection,
  }) {
    return SectionBooksState(
      booksBySection: booksBySection ?? this.booksBySection,
      isLoadingBySection: isLoadingBySection ?? this.isLoadingBySection,
      errorBySection: errorBySection ?? this.errorBySection,
    );
  }

  // ------------------------------
  //        FROM JSON
  // ------------------------------
  factory SectionBooksState.fromJson(Map<String, dynamic> json) {
    return SectionBooksState(
      booksBySection: (json["booksBySection"] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(
              key,
              List<SectionBook>.from(
                  (value as List).map((x) => SectionBook.fromJson(x))))),
      isLoadingBySection:
          (json["isLoadingBySection"] as Map<String, dynamic>? ?? {})
              .map((key, value) => MapEntry(key, value as bool)),
      errorBySection: (json["errorBySection"] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value as String?)),
    );
  }

  // ------------------------------
  //        TO JSON
  // ------------------------------
  Map<String, dynamic> toJson() {
    return {
      "booksBySection": booksBySection.map(
          (key, value) => MapEntry(key, value.map((x) => x.toJson()).toList())),
      "isLoadingBySection": isLoadingBySection,
      "errorBySection": errorBySection,
    };
  }
}
