import '../../features/auth/auth_state.dart';
import '../../features/dailyenglish/vocabulary/vocab_state.dart';
import '../../features/dailyenglish/idioms/idioms_state.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_state.dart';
import '../../features/dailyenglish/editorials/editorial_state.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_state.dart';  
import '../../features/currentaffairs/upscAwareness/upsc_state.dart'
    as upsc;  
import 'package:equatable/equatable.dart';

// Dummy UPSC Awareness Items
final List<upsc.UpscAwarenessItem> dummyUpscAwarenessItems = [
 const upsc.UpscAwarenessItem(
    imageUrl: "https://picsum.photos/200/300",
    title: "UPSC Topic 1",
    date: "2025-09-01",
    backgroundContextTitle: "Background of Topic 1",
    backgroundContextPoints: [
      upsc.BackgroundContextPoint(
        title: "Historical Context",
        explanation: "This topic emerged after important policy reforms.",
      ),
      upsc.BackgroundContextPoint(
        title: "Current Relevance",
        explanation: "This remains a major issue in 2025 due to reforms.",
      ),
    ],
    topicTitle: "Main Issue in Topic 1",
    subTopicTitles: [
      upsc.SubTopic(
        titleStatement: "Subtopic A",
        points: "Key details about Subtopic A",
      ),
      upsc.SubTopic(
        titleStatement: "Subtopic B",
        points: "Key details about Subtopic B",
      ),
    ],
    keyHighlightsOfTopic: "These are the main highlights.",
    keyHighlightsTitle: [
      upsc.KeyHighlight(
        points: [
          upsc.HighlightPoint(
            statement: "Highlight 1",
            subStatements: ["Detail 1.1", "Detail 1.2"],
          ),
          upsc.HighlightPoint(
            statement: "Highlight 2",
            subStatements: ["Detail 2.1"],
          ),
        ],
      ),
    ],
    consequencesTitle: "Consequences of Topic 1",
    subTopicConsequencesTitle: [
      upsc.SubTopic(
        titleStatement: "Economic Consequence",
        points: "Impact on economy and growth",
      ),
      upsc.SubTopic(
        titleStatement: "Social Consequence",
        points: "Impact on society and culture",
      ),
    ],
    conclusionPoints: [
      upsc.ConclusionPoint(
        title: "Final Note",
        explanation: "This will affect UPSC preparation strategies.",
      ),
    ],
    importantPoints: [
      upsc.ImportantPoint(
        title: "Important Law",
        explanation: "This law plays a crucial role here.",
      ),
      upsc.ImportantPoint(
        title: "Important Person",
        explanation: "A key leader influenced this topic.",
      ),
    ],
    questions: [
      upsc.Question(
        statement: "What is the key takeaway from Topic 1?",
        options: ["Option A", "Option B", "Option C"],
        correctOption: "Option A",
      ),
      upsc.Question(
        statement: "Which consequence is most significant?",
        options: ["Economic", "Social", "Cultural"],
        correctOption: "Economic",
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
  final BankingAwarenessState bankingAwarenessState;
  final upsc.UpscAwarenessState upscAwarenessState;

  const AppState({
    required this.authState,
    required this.vocabState,
    required this.idiomsState,
    required this.phrasalVerbsState,
    required this.editorialState,
    required this.bankingAwarenessState,
    required this.upscAwarenessState,
  });

  factory AppState.initial() => AppState(
        authState: AuthState.initial(),
        vocabState: VocabState.initial(),
        idiomsState: IdiomsState.initial(),
        phrasalVerbsState: PhrasalVerbsState.initial(),
        editorialState: EditorialState.initial(),
        bankingAwarenessState: BankingAwarenessState.initial(),
        upscAwarenessState: upsc.UpscAwarenessState(
          items: dummyUpscAwarenessItems,
          isLoading: false,
          error: null,
        ),
      );

  AppState copyWith({
    AuthState? authState,
    VocabState? vocabState,
    IdiomsState? idiomsState,
    PhrasalVerbsState? phrasalVerbsState,
    EditorialState? editorialState,
    BankingAwarenessState? bankingAwarenessState,
    upsc.UpscAwarenessState? upscAwarenessState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      vocabState: vocabState ?? this.vocabState,
      idiomsState: idiomsState ?? this.idiomsState,
      phrasalVerbsState: phrasalVerbsState ?? this.phrasalVerbsState,
      editorialState: editorialState ?? this.editorialState,
      bankingAwarenessState:
          bankingAwarenessState ?? this.bankingAwarenessState,
      upscAwarenessState: upscAwarenessState ?? this.upscAwarenessState,
    );
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'vocabState': vocabState.toJson(),
        'idiomsState': idiomsState.toJson(),
        'phrasalVerbsState': phrasalVerbsState.toJson(),
        'editorialState': editorialState.toJson(),
        'bankingAwarenessState': bankingAwarenessState.toJson(),
        // ✅ Now using real UPSC serialization
        'upscAwarenessState': upscAwarenessState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
      authState: AuthState.fromJson(json['authState']),
      vocabState: VocabState.fromJson(json['vocabState']),
      idiomsState: IdiomsState.fromJson(json['idiomsState']),
      phrasalVerbsState: PhrasalVerbsState.fromJson(json['phrasalVerbsState']),
      editorialState: EditorialState.fromJson(json['editorialState']),
      bankingAwarenessState: BankingAwarenessState.fromJson(json['bankingAwarenessState']),
       
      upscAwarenessState:
          upsc.UpscAwarenessState.fromJson(json['upscAwarenessState']),
    );
  }

  @override
  List<Object?> get props => [
        authState,
        vocabState,
        idiomsState,
        phrasalVerbsState,
        editorialState,
        bankingAwarenessState,
        upscAwarenessState,
      ];
}
