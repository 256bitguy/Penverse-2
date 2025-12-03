import 'package:penverse/core/models/book_model.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_model.dart';
class BookRef {
  final String id;

  BookRef({required this.id});

  factory BookRef.fromJson(Map<String, dynamic> json) {
    return BookRef(
      id: json["id"] ?? json["_id"] ?? "", // support both formats
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}
class SectionState {
  
  final List<Section> sections;

  
  final Map<String, List<BookRef>> booksBySection;

 
  final bool isLoadingSections;

  
  final String? loadingBooksForSectionId;

  /// Error
  final String? error;

  SectionState({
    required this.sections,
    required this.booksBySection,
    required this.isLoadingSections,
    required this.loadingBooksForSectionId,
    required this.error,
  });

  /// Initial state
  factory SectionState.initial() {
    return SectionState(
      sections: [],
      booksBySection: {},
      isLoadingSections: false,
      loadingBooksForSectionId: null,
      error: null,
    );
  }

  /// COPY WITH
  SectionState copyWith({
    List<Section>? sections,
    Map<String, List<BookRef>>? booksBySection,
    bool? isLoadingSections,
    String? loadingBooksForSectionId,
    String? error,
  }) {
    return SectionState(
      sections: sections ?? this.sections,
      booksBySection: booksBySection ?? this.booksBySection,
      isLoadingSections: isLoadingSections ?? this.isLoadingSections,
      loadingBooksForSectionId:
          loadingBooksForSectionId ?? this.loadingBooksForSectionId,
      error: error,
    );
  }

  /// -------------------------
  ///     ✅  TO JSON
  /// -------------------------
  // Map<String, dynamic> toJson() {
  //   return {
  //     "sections": sections.map((s) => s.toJson()).toList(),
  //     "booksBySection": booksBySection.map(
  //       (key, value) => MapEntry(
  //         key,
  //         value.map((b) => b.toJson()).toList(),
  //       ),
  //     ),
  //     "isLoadingSections": isLoadingSections,
  //     "loadingBooksForSectionId": loadingBooksForSectionId,
  //     "error": error,
  //   };
  // }

  /// -------------------------
  ///     🔄  FROM JSON
  /// -------------------------
  factory SectionState.fromJson(Map<String, dynamic> json) {
    return SectionState(
      sections: (json["sections"] as List<dynamic>? ?? [])
          .map((e) => Section.fromJson(e))
          .toList(),

      booksBySection:
          (json["booksBySection"] as Map<String, dynamic>? ?? {})
              .map((key, value) {
        final list = (value as List<dynamic>)
            .map((e) => BookRef.fromJson(e))
            .toList();
        return MapEntry(key, list);
      }),

      isLoadingSections: json["isLoadingSections"] ?? false,
      loadingBooksForSectionId: json["loadingBooksForSectionId"],
      error: json["error"],
    );
  }

  @override
  String toString() {
    return "SectionState(sections=${sections.length}, booksLoaded=${booksBySection.length})";
  }
}
