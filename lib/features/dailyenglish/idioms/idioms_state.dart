import 'package:equatable/equatable.dart';

class IdiomExample extends Equatable {
  final String sentence;
  final String situation;
  final String hindiSentence;

  const IdiomExample({
    required this.sentence,
    required this.situation,
    required this.hindiSentence,
  });

  factory IdiomExample.fromJson(Map<String, dynamic> json) => IdiomExample(
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

class IdiomItem extends Equatable {
  final String imageUrl;
  final String idiom;
  final String meaning;
  final String englishExplanation;
  final String hindiExplanation;
  final List<IdiomExample> examples;

  const IdiomItem({
    required this.imageUrl,
    required this.idiom,
    required this.meaning,
    required this.englishExplanation,
    required this.hindiExplanation,
    this.examples = const [],
  });

  factory IdiomItem.fromJson(Map<String, dynamic> json) => IdiomItem(
        imageUrl: json['image_url'] ?? '',
        idiom: json['idiom'] ?? '',
        meaning: json['meaning'] ?? '',
        englishExplanation: json['english_explanation'] ?? '',
        hindiExplanation: json['hindi_explanation'] ?? '',
        examples: (json['examples'] as List<dynamic>? ?? [])
            .map((e) => IdiomExample.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'idiom': idiom,
        'meaning': meaning,
        'english_explanation': englishExplanation,
        'hindi_explanation': hindiExplanation,
        'examples': examples.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props =>
      [imageUrl, idiom, meaning, englishExplanation, hindiExplanation, examples];
}

class IdiomsState extends Equatable {
  final List<IdiomItem> items;
  final bool isLoading;
  final String? error;

  const IdiomsState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  factory IdiomsState.initial() => const IdiomsState();

  IdiomsState copyWith({
    List<IdiomItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return IdiomsState(
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

  static IdiomsState fromJson(dynamic json) {
    if (json == null) return IdiomsState.initial();
    final map = Map<String, dynamic>.from(json as Map);
    return IdiomsState(
      items: (map['items'] as List<dynamic>? ?? [])
          .map((e) => IdiomItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      isLoading: map['isLoading'] ?? false,
      error: map['error'],
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
