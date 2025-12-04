 
import 'package:penverse/features/subjects/chapter/redux/chapter_model.dart';

class ChapterState {
  final bool isLoading;
  final List<Chapter> chapters;
  final String? error;

  ChapterState({
    this.isLoading = false,
    this.chapters = const [],
    this.error,
  });

  ChapterState copyWith({
    bool? isLoading,
    List<Chapter>? chapters,
    String? error,
  }) {
    return ChapterState(
      isLoading: isLoading ?? this.isLoading,
      chapters: chapters ?? this.chapters,
      error: error ?? this.error,
    );
  }

  factory ChapterState.initial() => ChapterState();

  factory ChapterState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ChapterState.initial();

    return ChapterState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      chapters: (json['chapters'] as List<dynamic>? ?? [])
          .map((item) => Chapter.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'chapters': chapters.map((chapter) => chapter.toJson()).toList(),
    };
  }
}
