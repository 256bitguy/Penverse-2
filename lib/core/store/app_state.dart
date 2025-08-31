import '../../features/auth/auth_state.dart';
import '../../features/dailyenglish/vocabulary/vocab_state.dart';
import '../../features/dailyenglish/idioms/idioms_state.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_state.dart';
import '../../features/dailyenglish/editorials/editorial_state.dart'; // <-- import editorial state
import 'package:equatable/equatable.dart';

final dummyIdioms = [
  IdiomItem(
    imageUrl: "https://picsum.photos/id/1/200/300",
    idiom: "Break the ice",
    meaning: "To initiate conversation in a social setting",
    englishExplanation:
        "Used when someone starts talking to ease tension in a group of strangers.",
    hindiExplanation: "चुप्पी तोड़ना या बातचीत शुरू करना।",
    examples: [
      IdiomExample(
        sentence: "He told a joke to break the ice at the party.",
        situation: "First meeting with strangers",
        hindiSentence: "उसने पार्टी में बातचीत शुरू करने के लिए मजाक सुनाया।",
      ),
      IdiomExample(
        sentence: "The teacher asked a fun question to break the ice.",
        situation: "First day of class",
        hindiSentence: "शिक्षक ने क्लास में माहौल हल्का करने के लिए मजेदार सवाल पूछा।",
      ),
    ],
  ),
  IdiomItem(
    imageUrl: "https://picsum.photos/id/1/200/300",
    idiom: "Once in a blue moon",
    meaning: "Something that happens very rarely",
    englishExplanation: "Used to describe an event that does not occur often.",
    hindiExplanation: "जो बहुत कम बार होता है।",
    examples: [
      IdiomExample(
        sentence: "He visits us once in a blue moon.",
        situation: "Rare family visits",
        hindiSentence: "वह हमसे बहुत ही कम मिलने आता है।",
      ),
    ],
  ),
  IdiomItem(
    imageUrl: "https://picsum.photos/id/1/200/300",
    idiom: "Under the weather",
    meaning: "Feeling sick or unwell",
    englishExplanation:
        "Describes someone not feeling well, usually mild sickness.",
    hindiExplanation: "थोड़ा बीमार महसूस करना।",
    examples: [
      IdiomExample(
        sentence: "I am feeling a bit under the weather today.",
        situation: "Calling in sick for work",
        hindiSentence: "मैं आज थोड़ा बीमार महसूस कर रहा हूँ।",
      ),
    ],
  ),
];

class AppState extends Equatable {
  final AuthState authState;
  final VocabState vocabState;
  final IdiomsState idiomsState;
  final PhrasalVerbsState phrasalVerbsState;
  final EditorialState editorialState; // <-- new editorial state

  const AppState({
    required this.authState,
    required this.vocabState,
    required this.idiomsState,
    required this.phrasalVerbsState,
    required this.editorialState,
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        editorialState: EditorialState.initial(),
        idiomsState: IdiomsState(
          items: dummyIdioms, // 👈 put dummy array here
          isLoading: false,
          error: null,
        ),
        phrasalVerbsState: PhrasalVerbsState.initial(),
        vocabState: VocabState.initial()
      );

  // copyWith (immutability)
  AppState copyWith({
    AuthState? authState,
    VocabState? vocabState,
    IdiomsState? idiomsState,
    PhrasalVerbsState? phrasalVerbsState,
    EditorialState? editorialState, // <-- copyWith for editorial
  }) {
    return AppState(
      authState: authState ?? this.authState,
      vocabState: vocabState ?? this.vocabState,
      idiomsState: idiomsState ?? this.idiomsState,
      phrasalVerbsState: phrasalVerbsState ?? this.phrasalVerbsState,
      editorialState: editorialState ?? this.editorialState,
    );
  }

  // JSON serialization for persistence
  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'vocabState': vocabState.toJson(),
        'idiomsState': idiomsState.toJson(),
        'phrasalVerbsState': phrasalVerbsState.toJson(),
        'editorialState': editorialState.toJson(), // <-- add editorial
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
      vocabState: VocabState.fromJson(json['vocabState']),
      idiomsState: IdiomsState.fromJson(json['idiomsState']),
      phrasalVerbsState: PhrasalVerbsState.fromJson(json['phrasalVerbsState']),
      editorialState: EditorialState.fromJson(
          json['editorialState']), // <-- parse editorial
    );
  }

  @override
  List<Object?> get props => [
        authState,
        vocabState,
        idiomsState,
        phrasalVerbsState,
        editorialState, // <-- include in props
      ];
}
