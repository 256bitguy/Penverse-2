// lib/features/subjects/topic/redux/topic_state.dart

/// ===============================
/// TOPIC DATA MODEL
/// ===============================
class Topic {
  final String id;
  final String title;
  final String chapterId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Topic({
    required this.id,
    required this.title,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create Topic from JSON (API -> Flutter)
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      chapterId: json['chapterId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert Topic to JSON (Flutter -> API)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'chapterId': chapterId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// ===============================
/// TOPIC REDUX STATE
/// ===============================
class TopicState {
  final bool isLoading;
  final List<Topic> topics;
  final String? error;

  TopicState({
    this.isLoading = false,
    this.topics = const [],
    this.error,
  });

  TopicState copyWith({
    bool? isLoading,
    List<Topic>? topics,
    String? error,
  }) {
    return TopicState(
      isLoading: isLoading ?? this.isLoading,
      topics: topics ?? this.topics,
      error: error ?? this.error,
    );
  }

  factory TopicState.initial() => TopicState();

  factory TopicState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return TopicState.initial();

    return TopicState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      topics: (json['topics'] as List<dynamic>? ?? [])
          .map((item) => Topic.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'topics': topics.map((topic) => topic.toJson()).toList(),
    };
  }
}
