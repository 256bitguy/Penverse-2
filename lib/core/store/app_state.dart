import '../../features/auth/auth_state.dart';
import '../../features/dailyenglish/vocabulary/vocab_state.dart';
import '../../features/dailyenglish/idioms/idioms_state.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_state.dart';
import '../../features/dailyenglish/editorials/editorial_state.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_state.dart'; // ✅ NEW
import 'package:equatable/equatable.dart';
final dummyBankingAwarenessItems = [
  BankingAwarenessItem(
    imageUrl:
        "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800",
    title: "India Signs Historic Climate Agreement",
    date: "2025-09-01",
    backgroundContextTitle: "Why This Matters",
    backgroundContextPoints: const [
      BackgroundContextPoint(
        title: "Global Climate Crisis",
        explanation:
            "The world is facing record-breaking heatwaves, making climate action urgent.",
      ),
      BackgroundContextPoint(
        title: "India’s Role",
        explanation:
            "As one of the largest carbon emitters, India’s policies strongly impact global climate goals.",
      ),
    ],
    topicTitle: "India’s Climate Agreement",
    subTopicTitles: const [
      SubTopic(
        titleStatement: "Key Provisions",
        points:
            "India committed to 40% renewable energy by 2030 and net zero by 2070.",
      ),
      SubTopic(
        titleStatement: "International Reactions",
        points:
            "World leaders praised the move, though some urged faster timelines.",
      ),
    ],
    keyHighlightsOfTopic:
        "The agreement includes massive solar expansion and investment in green hydrogen.",
    keyHighlightsTitle: const [
      KeyHighlight(points: [
        HighlightPoint(
          statement: "Solar Expansion",
          subStatements: ["100 GW capacity by 2030", "Investment in storage"],
        ),
        HighlightPoint(
          statement: "Green Hydrogen",
          subStatements: ["Pilot projects", "Export partnerships"],
        ),
      ])
    ],
    consequencesTitle: "Potential Consequences",
    subTopicConsequencesTitle: const [
      SubTopic(
        titleStatement: "Economic Impact",
        points: "Could create millions of green jobs but raise short-term costs.",
      ),
      SubTopic(
        titleStatement: "Political Impact",
        points:
            "Boosts India’s global leadership in climate talks, but opposition may push back.",
      ),
    ],
    conclusionPoints: const [
      ConclusionPoint(
        title: "A Step Forward",
        explanation:
            "While ambitious, success depends on strong implementation.",
      ),
    ],
    importantPoints: const [
      ImportantPoint(
        title: "India’s Energy Mix",
        explanation: "Currently 70% coal, transition will be challenging.",
      ),
      ImportantPoint(
        title: "International Cooperation",
        explanation: "India will need foreign investment to meet its targets.",
      ),
    ],
    questions: const [
      Question(
        statement: "What year has India committed to reach net zero?",
        options: ["2050", "2060", "2070", "2080"],
        correctOption: "2070",
      ),
      Question(
        statement: "What renewable energy target was set for 2030?",
        options: ["30%", "35%", "40%", "50%"],
        correctOption: "40%",
      ),
    ],
  ),
];

class AppState extends Equatable {
  final AuthState authState;
  final VocabState vocabState;
  final IdiomsState idiomsState;
  final PhrasalVerbsState phrasalVerbsState;
  final EditorialState editorialState;
  final BankingAwarenessState bankingAwarenessState; // ✅ NEW

  const AppState({
    required this.authState,
    required this.vocabState,
    required this.idiomsState,
    required this.phrasalVerbsState,
    required this.editorialState,
    required this.bankingAwarenessState, // ✅ NEW
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        vocabState: VocabState.initial(),
        idiomsState: IdiomsState.initial(),
        phrasalVerbsState: PhrasalVerbsState.initial(),
        editorialState: EditorialState.initial(),
        bankingAwarenessState: BankingAwarenessState(
          items: dummyBankingAwarenessItems,
          isLoading:false,
          error: null
        ), // ✅ NEW
      );

  AppState copyWith({
    AuthState? authState,
    VocabState? vocabState,
    IdiomsState? idiomsState,
    PhrasalVerbsState? phrasalVerbsState,
    EditorialState? editorialState,
    BankingAwarenessState? bankingAwarenessState, // ✅ NEW
  }) {
    return AppState(
      authState: authState ?? this.authState,
      vocabState: vocabState ?? this.vocabState,
      idiomsState: idiomsState ?? this.idiomsState,
      phrasalVerbsState: phrasalVerbsState ?? this.phrasalVerbsState,
      editorialState: editorialState ?? this.editorialState,
      bankingAwarenessState: bankingAwarenessState ?? this.bankingAwarenessState, // ✅
    );
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'vocabState': vocabState.toJson(),
        'idiomsState': idiomsState.toJson(),
        'phrasalVerbsState': phrasalVerbsState.toJson(),
        'editorialState': editorialState.toJson(),
        'bankingAwarenessState': {
          // ✅ You’ll need to implement toJson in BankingAwarenessState
        },
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
      vocabState: VocabState.fromJson(json['vocabState']),
      idiomsState: IdiomsState.fromJson(json['idiomsState']),
      phrasalVerbsState: PhrasalVerbsState.fromJson(json['phrasalVerbsState']),
      editorialState: EditorialState.fromJson(json['editorialState']),
      bankingAwarenessState: BankingAwarenessState(
          // ✅ You’ll need a proper fromJson in BankingAwarenessState
      ),
    );
  }

  @override
  List<Object?> get props => [
        authState,
        vocabState,
        idiomsState,
        phrasalVerbsState,
        editorialState,
        bankingAwarenessState, // ✅
      ];
}
