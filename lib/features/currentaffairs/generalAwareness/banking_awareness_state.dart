import 'package:meta/meta.dart';

@immutable
class BankingAwarenessState {
  final bool isLoading;
  final List<BankingAwarenessItem> items;
  final String? error;

  const BankingAwarenessState({
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  BankingAwarenessState copyWith({
    bool? isLoading,
    List<BankingAwarenessItem>? items,
    String? error,
  }) {
    return BankingAwarenessState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
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
}

// ========== Nested Models ==========

@immutable
class BackgroundContextPoint {
  final String title;
  final String explanation;

  const BackgroundContextPoint(
      {required this.title, required this.explanation});
}

@immutable
class SubTopic {
  final String titleStatement;
  final String points;

  const SubTopic({required this.titleStatement, required this.points});
}

@immutable
class KeyHighlight {
  final List<HighlightPoint> points;

  const KeyHighlight({this.points = const []});
}

@immutable
class HighlightPoint {
  final String statement;
  final List<String> subStatements;

  const HighlightPoint(
      {required this.statement, this.subStatements = const []});
}

@immutable
class ConclusionPoint {
  final String title;
  final String explanation;

  const ConclusionPoint({required this.title, required this.explanation});
}

@immutable
class ImportantPoint {
  final String title;
  final String explanation;

  const ImportantPoint({required this.title, required this.explanation});
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
}
