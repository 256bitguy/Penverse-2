import 'package:equatable/equatable.dart';

class EditorialOption extends Equatable {
  final String statement;

  const EditorialOption({required this.statement});

  factory EditorialOption.fromJson(Map<String, dynamic> json) =>
      EditorialOption(
        statement: json['statement'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'statement': statement,
      };

  @override
  List<Object?> get props => [statement];
}

class EditorialQuestion extends Equatable {
  final String statement;
  final List<EditorialOption> options;
  final String correctAnswer;

  const EditorialQuestion({
    required this.statement,
    this.options = const [],
    required this.correctAnswer,
  });

  factory EditorialQuestion.fromJson(Map<String, dynamic> json) =>
      EditorialQuestion(
        statement: json['statement'] ?? '',
        options: (json['options'] as List<dynamic>? ?? [])
            .map((e) =>
                EditorialOption.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        correctAnswer: json['correctAnswer'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'statement': statement,
        'options': options.map((o) => o.toJson()).toList(),
        'correctAnswer': correctAnswer,
      };

  @override
  List<Object?> get props => [statement, options, correctAnswer];
}

class EditorialItem extends Equatable {
  final String title;
  final List<String> paragraph;
  final List<EditorialQuestion> questions;

  const EditorialItem({
    required this.title,
    required this.paragraph,
    this.questions = const [],
  });

  factory EditorialItem.fromJson(Map<String, dynamic> json) => EditorialItem(
        title: json['title'] ?? '',
        paragraph: (json['paragraph'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        questions: (json['questions'] as List<dynamic>? ?? [])
            .map((e) => EditorialQuestion.fromJson(
                Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'paragraph': paragraph,
        'questions': questions.map((q) => q.toJson()).toList(),
      };

  @override
  List<Object?> get props => [title, paragraph, questions];
}

class EditorialState extends Equatable {
  final List<EditorialItem> items;
  final bool isLoading;
  final String? error;

  const EditorialState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  factory EditorialState.initial() => const EditorialState();

  EditorialState copyWith({
    List<EditorialItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return EditorialState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'isLoading': isLoading,
        'error': error,
      };

  static EditorialState fromJson(dynamic json) {
    if (json == null) return EditorialState.initial();
    final map = Map<String, dynamic>.from(json as Map);
    return EditorialState(
      items: (map['items'] as List<dynamic>? ?? [])
          .map((e) =>
              EditorialItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      isLoading: map['isLoading'] ?? false,
      error: map['error'],
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
