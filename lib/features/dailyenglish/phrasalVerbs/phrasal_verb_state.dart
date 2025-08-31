import 'package:equatable/equatable.dart';

class PhrasalVerbExample extends Equatable {
  final String sentence;
  final String situation;
  final String hindiSentence;

  const PhrasalVerbExample({
    required this.sentence,
    required this.situation,
    required this.hindiSentence,
  });

  factory PhrasalVerbExample.fromJson(Map<String, dynamic> json) => PhrasalVerbExample(
        sentence: json['sentence'] ?? '',
        situation: json['situation'] ?? '',
        hindiSentence: json['hindiSentence'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'sentence': sentence,
        'situation': situation,
        'hindiSentence': hindiSentence,
      };

  @override
  List<Object?> get props => [sentence, situation, hindiSentence];
}

class PhrasalVerbItem extends Equatable {
  final String imageUrl;
  final String phrasalVerb;
  final String meaning;
  final String englishExplanation;
  final String hindiExplanation;
  final List<PhrasalVerbExample> examples;

  const PhrasalVerbItem({
    required this.imageUrl,
    required this.phrasalVerb,
    required this.meaning,
    required this.englishExplanation,
    required this.hindiExplanation,
    this.examples = const [],
  });

  factory PhrasalVerbItem.fromJson(Map<String, dynamic> json) => PhrasalVerbItem(
        imageUrl: json['image_url'] ?? '',
        phrasalVerb: json['phrasal_verb'] ?? '',
        meaning: json['meaning'] ?? '',
        englishExplanation: json['english_explanation'] ?? '',
        hindiExplanation: json['hindi_explanation'] ?? '',
        examples: (json['examples'] as List<dynamic>? ?? [])
            .map((e) => PhrasalVerbExample.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'phrasal_verb': phrasalVerb,
        'meaning': meaning,
        'english_explanation': englishExplanation,
        'hindi_explanation': hindiExplanation,
        'examples': examples.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [imageUrl, phrasalVerb, meaning, englishExplanation, hindiExplanation, examples];
}

class PhrasalVerbsState extends Equatable {
  final List<PhrasalVerbItem> items;
  final bool isLoading;
  final String? error;

  const PhrasalVerbsState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  factory PhrasalVerbsState.initial() => const PhrasalVerbsState();

  PhrasalVerbsState copyWith({
    List<PhrasalVerbItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return PhrasalVerbsState(
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

  static PhrasalVerbsState fromJson(dynamic json) {
    if (json == null) return PhrasalVerbsState.initial();
    final map = Map<String, dynamic>.from(json as Map);
    return PhrasalVerbsState(
      items: (map['items'] as List<dynamic>? ?? [])
          .map((e) => PhrasalVerbItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      isLoading: map['isLoading'] ?? false,
      error: map['error'],
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
