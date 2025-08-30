import '../../features/auth/auth_state.dart';
import '../../features/dailyenglish/vocabulary/vocab_state.dart';
import 'package:equatable/equatable.dart';
 
final fakeVocabItems = [
  const VocabItem(
    imageUrl: "https://picsum.photos/seed/word1/400/200",
    word: "Serendipity",
    partOfSpeech: "Noun",
    englishExplanation: "The occurrence of events by chance in a happy or beneficial way.",
    hindiExplanation: "सौभाग्य से सुखद घटनाएँ होना",
    synonyms: [
      Synonym(
        word: "Fluke",
        meaning: "A stroke of luck",
        englishExplanation: "Something good that happens unexpectedly.",
        hindiExplanation: "अचानक हुआ सौभाग्य",
      ),
      Synonym(
        word: "Chance",
        meaning: "Accidental occurrence",
        englishExplanation: "Happening without planning.",
        hindiExplanation: "संयोग",
      ),
    ],
    antonyms: [
      Antonym(
        word: "Misfortune",
        meaning: "Bad luck",
        englishExplanation: "An unlucky event.",
        hindiExplanation: "दुर्भाग्य",
      ),
    ],
  ),
  const VocabItem(
    imageUrl: "https://picsum.photos/seed/word2/400/200",
    word: "Ephemeral",
    partOfSpeech: "Adjective",
    englishExplanation: "Lasting for a very short time.",
    hindiExplanation: "क्षणभंगुर, जो अधिक देर तक न टिके",
    synonyms: [
      Synonym(
        word: "Transient",
        meaning: "Temporary",
        englishExplanation: "Not lasting long.",
        hindiExplanation: "क्षणिक",
      ),
    ],
    antonyms: [
      Antonym(
        word: "Eternal",
        meaning: "Never-ending",
        englishExplanation: "Lasting forever.",
        hindiExplanation: "शाश्वत",
      ),
    ],
  ),
const VocabItem(
    imageUrl: "https://picsum.photos/seed/word3/400/200",
    word: "Tenacious",
    partOfSpeech: "Adjective",
    englishExplanation: "Holding firmly; persistent.",
    hindiExplanation: "दृढ़, जिद्दी",
    synonyms: [
      Synonym(
        word: "Persistent",
        meaning: "Continuing firmly",
        englishExplanation: "Not giving up easily.",
        hindiExplanation: "लगातार प्रयास करने वाला",
      ),
    ],
    antonyms: [
      Antonym(
        word: "Weak",
        meaning: "Lacking strength",
        englishExplanation: "Not strong or determined.",
        hindiExplanation: "कमजोर",
      ),
    ],
  ),
];

class AppState extends Equatable {
  final AuthState authState;
  final VocabState vocabState;

  const AppState({
    required this.authState,
    required this.vocabState,
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        vocabState: VocabState(
        items: fakeVocabItems,  // ✅ inject dummy data here
        isLoading: false,
        error: null,
      ),
      );

  // copyWith (immutability)
  AppState copyWith({
    AuthState? authState,
    VocabState? vocabState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      vocabState: vocabState ?? this.vocabState,
    );
  }

  // ✅ JSON serialization for persistence
  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'vocabState': vocabState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
      vocabState: VocabState.fromJson(json['vocabState']),
    );
  }

  @override
  List<Object?> get props => [authState, vocabState];
}
