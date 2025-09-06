// lib/features/subjects/data/subject_state.dart

/// ===============================
/// SUBJECT DATA MODEL
/// ===============================
class Subject {
  final String id;
  final String name;
  final String description;
  final String iconType; // "local" or "remote"
  final String iconValue; // asset key or URL
  final int totalBooks;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subject({
    required this.id,
    required this.name,
    this.description = "",
    required this.iconType,
    required this.iconValue,
    this.totalBooks = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create Subject from JSON (API -> Flutter)
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      iconType: json['iconType'] ?? 'local',
      iconValue: json['iconValue'] ?? '',
      totalBooks: json['totalBooks'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert Subject to JSON (Flutter -> API)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'iconType': iconType,
      'iconValue': iconValue,
      'totalBooks': totalBooks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// ===============================
/// SUBJECT REDUX STATE
/// ===============================
class SubjectState {
  final bool isLoading;
  final List<Subject> subjects;
  final String? error;

  SubjectState({
    this.isLoading = false,
    this.subjects = const [],
    this.error,
  });

  /// Create a copy of the state with optional changes
  SubjectState copyWith({
    bool? isLoading,
    List<Subject>? subjects,
    String? error,
  }) {
    return SubjectState(
      isLoading: isLoading ?? this.isLoading,
      subjects: subjects ?? this.subjects,
      error: error ?? this.error,
    );
  }

  /// Initial empty state
  factory SubjectState.initial() => SubjectState();

  /// ===============================
  /// JSON Serialization for Redux Persistence
  /// ===============================

  /// Convert JSON -> SubjectState
  factory SubjectState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SubjectState.initial();

    return SubjectState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      subjects: (json['subjects'] as List<dynamic>? ?? [])
          .map((item) => Subject.fromJson(item))
          .toList(),
    );
  }

  /// Convert SubjectState -> JSON
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }
}
