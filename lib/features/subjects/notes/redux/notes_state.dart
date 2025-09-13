// notes_state.dart
class PointModel {
  final String text;                // The main point
  final String explanation;         // Explanation of the point
  final List<String> examples;      // ✅ Array of examples
  final List<String> images;        // Array of images

  PointModel({
    required this.text,
    required this.explanation,
    required this.examples,
    required this.images,
  });

 factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
      text: json['text'] ?? '',
      explanation: json['explanation'] ?? '',
      examples: (json['examples'] as List?)?.map((e) => e.toString()).toList() ?? [],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );


  Map<String, dynamic> toJson() => {
        'text': text,
        'explanation': explanation,
        'examples': examples,
        'images': images,
      };
}

class SubtopicModel {
  final String name;
  final List<String> images;
  final List<PointModel> points;

  SubtopicModel({
    required this.name,
    required this.images,
    required this.points,
  });

  factory SubtopicModel.fromJson(Map<String, dynamic> json) => SubtopicModel(
        name: json['name'] ?? '',
        images: List<String>.from(json['images'] ?? []),
        points: (json['points'] as List? ?? [])
            .map((p) => PointModel.fromJson(p))
            .toList(),
      );
}

class TopicModel {
  final String name;
  final List<String> images;
  final List<SubtopicModel> subtopics;

  TopicModel({
    required this.name,
    required this.images,
    required this.subtopics,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
        name: json['name'] ?? '',
        images: List<String>.from(json['images'] ?? []),
        subtopics: (json['subtopics'] as List? ?? [])
            .map((s) => SubtopicModel.fromJson(s))
            .toList(),
      );
}

class NoteModel {
  final String id;
  final String topicId;
  final String heading;
  final List<String> images;
  final List<TopicModel> topics;

  NoteModel({
    required this.id,
    required this.topicId,
    required this.heading,
    required this.images,
    required this.topics,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json['_id'] ?? '',
        topicId: json['topicId'] ?? '',
        heading: json['heading'] ?? '',
        images: List<String>.from(json['images'] ?? []),
        topics: (json['topics'] as List? ?? [])
            .map((t) => TopicModel.fromJson(t))
            .toList(),
      );
}

/// ---------- Redux State ----------

class NotesState {
  final NoteModel? note;
  final bool isLoading;
  final String error;

  NotesState({
    this.note,
    this.isLoading = false,
    this.error = '',
  });

  /// Initial empty state
  factory NotesState.initial() => NotesState(
        note: null,
        isLoading: false,
        error: '',
      );

  /// Create a copy of state with optional modifications
  NotesState copyWith({
    NoteModel? note,
    bool? isLoading,
    String? error,
  }) {
    return NotesState(
      note: note ?? this.note,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Create state from JSON
  factory NotesState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return NotesState.initial();

    return NotesState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'] ?? '',
      note: json['note'] != null
          ? NoteModel.fromJson(Map<String, dynamic>.from(json['note']))
          : null,
    );
  }

  /// Convert state to JSON
   
}