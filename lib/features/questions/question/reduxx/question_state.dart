// questions_state.dart

class StatementModel {
  final int order;
  final String text;

  StatementModel({
    required this.order,
    required this.text,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) => StatementModel(
        order: json['order'] ?? 0,
        text: json['text'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'order': order,
        'text': text,
      };
}

class OptionModel {
  final int order;
  final String text;
  final String? imageUrl;

  OptionModel({
    required this.order,
    required this.text,
    this.imageUrl,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        order: json['order'] ?? 0,
        text: json['text'] ?? '',
        imageUrl: json['imageUrl'] is String ? json['imageUrl'] : null,
      );

  Map<String, dynamic> toJson() => {
        'order': order,
        'text': text,
        'imageUrl': imageUrl,
      };
}

class VariantAssertionReason {
  final String assertion;
  final String reason;
  final String correctOption;

  VariantAssertionReason({
    required this.assertion,
    required this.reason,
    required this.correctOption,
  });

  factory VariantAssertionReason.fromJson(Map<String, dynamic> json) =>
      VariantAssertionReason(
        assertion: json['assertion'] ?? '',
        reason: json['reason'] ?? '',
        correctOption: json['correctOption'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'assertion': assertion,
        'reason': reason,
        'correctOption': correctOption,
      };
}

class VariantChronologyItem {
  final String event;
  final int year;

  VariantChronologyItem({
    required this.event,
    required this.year,
  });

  factory VariantChronologyItem.fromJson(Map<String, dynamic> json) =>
      VariantChronologyItem(
        event: json['event'] ?? '',
        year: json['year'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'event': event,
        'year': year,
      };
}

class VariantChronology {
  final List<VariantChronologyItem> items;
  final List<int> correctOrder;

  VariantChronology({
    required this.items,
    required this.correctOrder,
  });

  factory VariantChronology.fromJson(Map<String, dynamic> json) =>
      VariantChronology(
        items: (json['items'] as List? ?? [])
            .map((i) => VariantChronologyItem.fromJson(Map<String, dynamic>.from(i)))
            .toList(),
        correctOrder: List<int>.from(json['correctOrder'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'items': items.map((i) => i.toJson()).toList(),
        'correctOrder': correctOrder,
      };
}

class VariantTrueFalse {
  final String statement;
  final bool answer;

  VariantTrueFalse({
    required this.statement,
    required this.answer,
  });

  factory VariantTrueFalse.fromJson(Map<String, dynamic> json) =>
      VariantTrueFalse(
        statement: json['statement'] ?? '',
        answer: json['answer'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'statement': statement,
        'answer': answer,
      };
}

class VariantModel {
  final VariantAssertionReason? assertionReason;
  final VariantChronology? chronology;
  final VariantTrueFalse? trueFalse;

  VariantModel({
    this.assertionReason,
    this.chronology,
    this.trueFalse,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) => VariantModel(
        assertionReason: json['assertionReason'] != null
            ? VariantAssertionReason.fromJson(Map<String, dynamic>.from(json['assertionReason']))
            : null,
        chronology: json['chronology'] != null
            ? VariantChronology.fromJson(Map<String, dynamic>.from(json['chronology']))
            : null,
        trueFalse: json['trueFalse'] != null
            ? VariantTrueFalse.fromJson(Map<String, dynamic>.from(json['trueFalse']))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'assertionReason': assertionReason?.toJson(),
        'chronology': chronology?.toJson(),
        'trueFalse': trueFalse?.toJson(),
      };
}

class QuestionModel {
  final String id;
  final String? topicId;
  final String? topicName;
  final List<String> tags;
  final String? instructions;
  final String? questionText;
  final List<String> images;
  final List<StatementModel> statements;
  final List<OptionModel> options;
  final int? singleCorrectIndex;
  final List<int>? multipleCorrectIndexes;
  final String? solutionText;
  final String? solutionImage;
  final String type;
  final String difficulty;
  final Map<String, dynamic>? meta;
  final VariantModel? variant;
  final DateTime date;

  QuestionModel({
    required this.id,
    this.topicId,
    this.topicName,
    this.tags = const [],
    this.instructions,
    this.questionText,
    this.images = const [],
    this.statements = const [],
    this.options = const [],
    this.singleCorrectIndex,
    this.multipleCorrectIndexes,
    this.solutionText,
    this.solutionImage,
    required this.type,
    required this.difficulty,
    this.meta,
    this.variant,
    required this.date,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    String? parseString(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      return value.toString();
    }

    return QuestionModel(
      id: parseString(json['_id']) ?? '',
      topicId: parseString(json['topicId']),
      topicName: parseString(json['topicName']),
      tags: List<String>.from(json['tags'] ?? []),
      instructions: parseString(json['instructions']),
      questionText: parseString(json['questionText']),
      images: List<String>.from(json['images'] ?? []),
      statements: (json['statements'] as List? ?? [])
          .map((s) => StatementModel.fromJson(Map<String, dynamic>.from(s)))
          .toList(),
      options: (json['options'] as List? ?? [])
          .map((o) => OptionModel.fromJson(Map<String, dynamic>.from(o)))
          .toList(),
      singleCorrectIndex: json['singleCorrectIndex'],
      multipleCorrectIndexes: json['multipleCorrectIndexes'] != null
          ? List<int>.from(json['multipleCorrectIndexes'])
          : null,
      solutionText: parseString(json['solutionText']),
      solutionImage: parseString(json['solutionImage']),
      type: parseString(json['type']) ?? 'single',
      difficulty: parseString(json['difficulty']) ?? 'medium',
      meta: json['meta'] != null ? Map<String, dynamic>.from(json['meta']) : null,
      variant: json['variant'] != null
          ? VariantModel.fromJson(Map<String, dynamic>.from(json['variant']))
          : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'topicId': topicId,
        'topicName': topicName,
        'tags': tags,
        'instructions': instructions,
        'questionText': questionText,
        'images': images,
        'statements': statements.map((s) => s.toJson()).toList(),
        'options': options.map((o) => o.toJson()).toList(),
        'singleCorrectIndex': singleCorrectIndex,
        'multipleCorrectIndexes': multipleCorrectIndexes,
        'solutionText': solutionText,
        'solutionImage': solutionImage,
        'type': type,
        'difficulty': difficulty,
        'meta': meta,
        'variant': variant?.toJson(),
        'date': date.toIso8601String(),
      };
}

/// ---------- Redux State ----------

class QuestionsState {
  final List<QuestionModel> questions;
  final bool isLoading;
  final String error;

  QuestionsState({
    this.questions = const [],
    this.isLoading = false,
    this.error = '',
  });

  factory QuestionsState.initial() => QuestionsState(
        questions: [],
        isLoading: false,
        error: '',
      );

  QuestionsState copyWith({
    List<QuestionModel>? questions,
    bool? isLoading,
    String? error,
  }) {
    return QuestionsState(
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  factory QuestionsState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return QuestionsState.initial();
    return QuestionsState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'] ?? '',
      questions: (json['questions'] as List? ?? [])
          .map((q) => QuestionModel.fromJson(Map<String, dynamic>.from(q)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'questions': questions.map((q) => q.toJson()).toList(),
        'isLoading': isLoading,
        'error': error,
      };
}
