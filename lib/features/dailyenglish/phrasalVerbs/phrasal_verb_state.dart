import 'package:equatable/equatable.dart';

/// Represents a single example for a phrasal verb
class PhrasalVerbExample extends Equatable {
  final String sentence;
  final String situation;
  final String hindiSentence;

  const PhrasalVerbExample({
    required this.sentence,
    required this.situation,
    required this.hindiSentence,
  });

  factory PhrasalVerbExample.fromJson(Map<String, dynamic> json) {
    return PhrasalVerbExample(
      sentence: json['sentence']?.toString() ?? '',
      situation: json['situation']?.toString() ?? '',
      hindiSentence: json['hindiSentence']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'sentence': sentence,
        'situation': situation,
        'hindiSentence': hindiSentence,
      };

  @override
  List<Object?> get props => [sentence, situation, hindiSentence];
}

/// Represents a single phrasal verb item
class PhrasalVerbItem extends Equatable {
  final String id;
  final String topicId;
  final String imageUrl;
  final String phrasalVerb;
  final String meaning;
  final String englishExplanation;
  final String hindiExplanation;
  final List<PhrasalVerbExample> examples;
  final String createdAt;
  final String updatedAt;
  final int version;

  const PhrasalVerbItem({
    required this.id,
    required this.topicId,
    required this.imageUrl,
    required this.phrasalVerb,
    required this.meaning,
    required this.englishExplanation,
    required this.hindiExplanation,
    this.examples = const [],
    this.createdAt = '',
    this.updatedAt = '',
    this.version = 0,
  });

  factory PhrasalVerbItem.fromJson(Map<String, dynamic> json) {
    return PhrasalVerbItem(
      id: json['_id']?.toString() ?? '',
      topicId: json['topicId']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      phrasalVerb: json['phrasalVerb']?.toString() ?? '',
      meaning: json['meaning']?.toString() ?? '',
      englishExplanation: json['englishExplanation']?.toString() ?? '',
      hindiExplanation: json['hindiExplanation']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      version: json['__v'] is int ? json['__v'] : int.tryParse(json['__v']?.toString() ?? '0') ?? 0,
      examples: (json['examples'] is List)
          ? (json['examples'] as List)
              .whereType<Map<String, dynamic>>()
              .map((e) => PhrasalVerbExample.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'topicId': topicId,
        'imageUrl': imageUrl,
        'phrasalVerb': phrasalVerb,
        'meaning': meaning,
        'englishExplanation': englishExplanation,
        'hindiExplanation': hindiExplanation,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': version,
        'examples': examples.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        topicId,
        imageUrl,
        phrasalVerb,
        meaning,
        englishExplanation,
        hindiExplanation,
        examples,
        createdAt,
        updatedAt,
        version,
      ];
}

/// State for managing a list of phrasal verbs
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

    try {
      final map = Map<String, dynamic>.from(json as Map);
      return PhrasalVerbsState(
        items: (map['items'] is List)
            ? (map['items'] as List)
                .whereType<Map<String, dynamic>>()
                .map((e) =>
                    PhrasalVerbItem.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        isLoading: map['isLoading'] ?? false,
        error: map['error']?.toString(),
      );
    } catch (e) {
      print('Error parsing PhrasalVerbsState JSON: $e');
      return PhrasalVerbsState.initial();
    }
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
