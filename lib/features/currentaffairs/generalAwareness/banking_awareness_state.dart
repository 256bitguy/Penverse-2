import 'package:meta/meta.dart';

@immutable
class BankingAwarenessState {
  final bool isLoading;
  final bool isEmpty;
  final List<BankingAwarenessItem> items;
  final String? error;

  const BankingAwarenessState({
    this.isLoading = false,
    this.isEmpty = false,
    this.items = const [],
    this.error,
  });

  factory BankingAwarenessState.initial() => const BankingAwarenessState();

  BankingAwarenessState copyWith({
    bool? isLoading,
    List<BankingAwarenessItem>? items,
    String? error,
    bool? isEmpty,
  }) {
    return BankingAwarenessState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'items': items.map((e) => e.toJson()).toList(),
        'error': error,
      };

  factory BankingAwarenessState.fromJson(Map<String, dynamic> json) {
    return BankingAwarenessState(
      isLoading: json['isLoading'] ?? false,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => BankingAwarenessItem.fromJson(e))
          .toList(),
      error: json['error'],
    );
  }
}

@immutable
class BankingAwarenessItem {
  final String imageUrl;
  final String title;
  final String date;
  final String? backgroundContextTitle;
  final List<BackgroundContextPoint> backgroundContextPoints;
  final String topicTitle;
  final List<SubTopic> subTopicTitles;
  final String? keyHighlightsOfTopic;
  final List<KeyHighlight> keyHighlightsTitle;
  final String? consequencesTitle;
  final List<SubTopic> subTopicConsequencesTitle;
  final List<ConclusionPoint> conclusionPoints;
  final List<ImportantPoint> importantPoints;
  final List<Question> questions;

  const BankingAwarenessItem({
    required this.imageUrl,
    required this.title,
    required this.date,
    this.backgroundContextTitle,
    this.backgroundContextPoints = const [],
    required this.topicTitle,
    this.subTopicTitles = const [],
    this.keyHighlightsOfTopic,
    this.keyHighlightsTitle = const [],
    this.consequencesTitle,
    this.subTopicConsequencesTitle = const [],
    this.conclusionPoints = const [],
    this.importantPoints = const [],
    this.questions = const [],
  });

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'title': title,
        'date': date,
        'backgroundContextTitle': backgroundContextTitle,
        'backgroundContextPoints':
            backgroundContextPoints.map((e) => e.toJson()).toList(),
        'topicTitle': topicTitle,
        'subTopicTitles': subTopicTitles.map((e) => e.toJson()).toList(),
        'keyHighlightsOfTopic': keyHighlightsOfTopic,
        'keyHighlightsTitle':
            keyHighlightsTitle.map((e) => e.toJson()).toList(),
        'consequencesTitle': consequencesTitle,
        'subTopicConsequencesTitle':
            subTopicConsequencesTitle.map((e) => e.toJson()).toList(),
        'conclusionPoints': conclusionPoints.map((e) => e.toJson()).toList(),
        'importantPoints': importantPoints.map((e) => e.toJson()).toList(),
        'questions': questions.map((e) => e.toJson()).toList(),
      };

  factory BankingAwarenessItem.fromJson(Map<String, dynamic> json) {
    return BankingAwarenessItem(
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      backgroundContextTitle: json['backgroundContextTitle'],
      backgroundContextPoints:
          (json['backgroundContextPoints'] as List<dynamic>? ?? [])
              .map((e) => BackgroundContextPoint.fromJson(e))
              .toList(),
      topicTitle: json['topicTitle'] ?? '',
      subTopicTitles: (json['subTopicTitles'] as List<dynamic>? ?? [])
          .map((e) => SubTopic.fromJson(e))
          .toList(),
      keyHighlightsOfTopic: json['keyHighlightsOfTopic'],
      keyHighlightsTitle: (json['keyHighlightsTitle'] as List<dynamic>? ?? [])
          .map((e) => KeyHighlight.fromJson(e))
          .toList(),
      consequencesTitle: json['consequencesTitle'],
      subTopicConsequencesTitle:
          (json['subTopicConsequencesTitle'] as List<dynamic>? ?? [])
              .map((e) => SubTopic.fromJson(e))
              .toList(),
      conclusionPoints: (json['conclusionPoints'] as List<dynamic>? ?? [])
          .map((e) => ConclusionPoint.fromJson(e))
          .toList(),
      importantPoints: (json['importantPoints'] as List<dynamic>? ?? [])
          .map((e) => ImportantPoint.fromJson(e))
          .toList(),
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((e) => Question.fromJson(e))
          .toList(),
    );
  }
}

@immutable
class BackgroundContextPoint {
  final String title;
  final String explanation;

  const BackgroundContextPoint(
      {required this.title, required this.explanation});

  Map<String, dynamic> toJson() => {
        'title': title,
        'explanation': explanation,
      };

  factory BackgroundContextPoint.fromJson(Map<String, dynamic> json) {
    return BackgroundContextPoint(
      title: json['title'] ?? '',
      explanation: json['explanation'] ?? '',
    );
  }
}

@immutable
class SubTopic {
  final String titleStatement;
  final String points;

  const SubTopic({required this.titleStatement, required this.points});

  Map<String, dynamic> toJson() => {
        'titleStatement': titleStatement,
        'points': points,
      };

  factory SubTopic.fromJson(Map<String, dynamic> json) {
    return SubTopic(
      titleStatement: json['titleStatement'] ?? '',
      points: json['points'] ?? '',
    );
  }
}

@immutable
class KeyHighlight {
  final List<HighlightPoint> points;

  const KeyHighlight({this.points = const []});

  Map<String, dynamic> toJson() => {
        'points': points.map((e) => e.toJson()).toList(),
      };

  factory KeyHighlight.fromJson(Map<String, dynamic> json) {
    return KeyHighlight(
      points: (json['points'] as List<dynamic>? ?? [])
          .map((e) => HighlightPoint.fromJson(e))
          .toList(),
    );
  }
}

@immutable
class HighlightPoint {
  final String statement;
  final List<String> subStatements;

  const HighlightPoint(
      {required this.statement, this.subStatements = const []});

  Map<String, dynamic> toJson() => {
        'statement': statement,
        'subStatements': subStatements,
      };

  factory HighlightPoint.fromJson(Map<String, dynamic> json) {
    return HighlightPoint(
      statement: json['statement'] ?? '',
      subStatements: (json['subStatements'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

@immutable
class ConclusionPoint {
  final String title;
  final String explanation;

  const ConclusionPoint({required this.title, required this.explanation});

  Map<String, dynamic> toJson() => {
        'title': title,
        'explanation': explanation,
      };

  factory ConclusionPoint.fromJson(Map<String, dynamic> json) {
    return ConclusionPoint(
      title: json['title'] ?? '',
      explanation: json['explanation'] ?? '',
    );
  }
}

@immutable
class ImportantPoint {
  final String title;
  final String explanation;

  const ImportantPoint({required this.title, required this.explanation});

  Map<String, dynamic> toJson() => {
        'title': title,
        'explanation': explanation,
      };

  factory ImportantPoint.fromJson(Map<String, dynamic> json) {
    return ImportantPoint(
      title: json['title'] ?? '',
      explanation: json['explanation'] ?? '',
    );
  }
}

@immutable
class Question {
  final String statement;
  final List<String> options;
  final String correctOption;

  const Question({
    required this.statement,
    this.options = const [],
    required this.correctOption,
  });

  Map<String, dynamic> toJson() => {
        'statement': statement,
        'options': options,
        'correctOption': correctOption,
      };

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      statement: json['statement'] ?? '',
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      correctOption: json['correctOption'] ?? '',
    );
  }
}
