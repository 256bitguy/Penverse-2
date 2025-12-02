// lib/features/sections/data/section_state.dart

/// ===============================
/// SECTION DATA MODEL
/// ===============================
class Section {
  final String id;
  final String libraryId;
  final String sectionName;
  final List<String> books; // List of book IDs

  Section({
    required this.id,
    required this.libraryId,
    required this.sectionName,
    this.books = const [],
  });

  /// Create Section from JSON (API → Flutter)
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['_id'] ?? '',
      libraryId: json['libraryId'] ?? '',
      sectionName: json['sectionName'] ?? '',
      books: (json['books'] as List<dynamic>? ?? [])
          .map((b) => b.toString())
          .toList(),
    );
  }

  /// Convert Section to JSON (Flutter → API)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'libraryId': libraryId,
      'sectionName': sectionName,
      'books': books,
    };
  }
}

/// ===============================
/// SECTION REDUX STATE
/// ===============================
class SectionState {
  final bool isLoading;
  final List<Section> sections;
  final String? error;

  SectionState({
    this.isLoading = false,
    this.sections = const [],
    this.error,
  });

  /// CopyWith for state updates
  SectionState copyWith({
    bool? isLoading,
    List<Section>? sections,
    String? error,
  }) {
    return SectionState(
      isLoading: isLoading ?? this.isLoading,
      sections: sections ?? this.sections,
      error: error ?? this.error,
    );
  }

  /// Initial empty state
  factory SectionState.initial() => SectionState();

  /// ===============================
  /// JSON Serialization for persistence
  /// ===============================
  factory SectionState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SectionState.initial();

    return SectionState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      sections: (json['sections'] as List<dynamic>? ?? [])
          .map((item) => Section.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'sections': sections.map((s) => s.toJson()).toList(),
    };
  }
}
