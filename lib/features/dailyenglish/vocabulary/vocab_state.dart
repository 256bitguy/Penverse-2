import 'package:equatable/equatable.dart';

class Synonym extends Equatable {
  final String word;
  final String meaning;
  final String englishExplanation;
  final String hindiExplanation;

  const Synonym({
    required this.word,
    required this.meaning,
    required this.englishExplanation,
    required this.hindiExplanation,
  });

  factory Synonym.fromJson(Map<String, dynamic> json) => Synonym(
        word: json['word'] ?? '',
        meaning: json['meaning'] ?? '',
        englishExplanation: json['englishExplanation'] ?? '',
        hindiExplanation: json['hindiExplanation'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'word': word,
        'meaning': meaning,
        'englishExplanation': englishExplanation,
        'hindiExplanation': hindiExplanation,
      };

  @override
  List<Object?> get props => [word, meaning, englishExplanation, hindiExplanation];
}

// You can reuse Synonym as Antonym; keeping a separate class if you prefer:
class Antonym extends Synonym {
  const Antonym({
    required super.word,
    required super.meaning,
    required super.englishExplanation,
    required super.hindiExplanation,
  });

  factory Antonym.fromJson(Map<String, dynamic> json) => Antonym(
        word: json['word'] ?? '',
        meaning: json['meaning'] ?? '',
        englishExplanation: json['englishExplanation'] ?? '',
        hindiExplanation: json['hindiExplanation'] ?? '',
      );
}

class VocabItem extends Equatable {
  final String imageUrl;
  final String word;
  final String partOfSpeech;
  final String englishExplanation;
  final String hindiExplanation;
  final List<Synonym> synonyms;
  final List<Antonym> antonyms;

  const VocabItem({
    required this.imageUrl,
    required this.word,
    required this.partOfSpeech,
    required this.englishExplanation,
    required this.hindiExplanation,
    this.synonyms = const [],
    this.antonyms = const [],
  });

  factory VocabItem.fromJson(Map<String, dynamic> json) => VocabItem(
        imageUrl: json['image_url'] ?? '',
        word: json['word'] ?? '',
        partOfSpeech: json['part_of_speech'] ?? '',
        englishExplanation: json['english_explanation'] ?? '',
        hindiExplanation: json['hindiExplanation'] ?? '',
        synonyms: (json['synonyms'] as List<dynamic>? ?? [])
            .map((e) => Synonym.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        antonyms: (json['antonyms'] as List<dynamic>? ?? [])
            .map((e) => Antonym.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'word': word,
        'part_of_speech': partOfSpeech,
        'english_explanation': englishExplanation,
        'hindiExplanation': hindiExplanation,
        'synonyms': synonyms.map((s) => s.toJson()).toList(),
        'antonyms': antonyms.map((a) => a.toJson()).toList(),
      };

  @override
  List<Object?> get props =>
      [imageUrl, word, partOfSpeech, englishExplanation, hindiExplanation, synonyms, antonyms];
}

class VocabState extends Equatable {
  final List<VocabItem> items;
  final bool isLoading;
  final String? error;

  const VocabState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  factory VocabState.initial() => const VocabState();

  VocabState copyWith({
    List<VocabItem>? items,
    bool? isLoading,
    String? error, // pass null explicitly to clear
  }) {
    return VocabState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // ✅ Add these two to fix your error
  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'isLoading': isLoading,
        'error': error,
      };

  static VocabState fromJson(dynamic json) {
    if (json == null) return VocabState.initial();
    final map = Map<String, dynamic>.from(json as Map);
    return VocabState(
      items: (map['items'] as List<dynamic>? ?? [])
          .map((e) => VocabItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      isLoading: map['isLoading'] ?? false,
      error: map['error'],
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
