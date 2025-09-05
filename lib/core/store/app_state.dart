import '../../features/auth/auth_state.dart';
import '../../features/dailyenglish/vocabulary/vocab_state.dart';
import '../../features/dailyenglish/idioms/idioms_state.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_state.dart';
import '../../features/dailyenglish/editorials/editorial_state.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_state.dart';
import '../../features/currentaffairs/upscAwareness/upsc_state.dart' as upsc;
import 'package:equatable/equatable.dart';

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
        upscAwarenessState: upsc.UpscAwarenessState.initial(),
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
      bankingAwarenessState:
          BankingAwarenessState.fromJson(json['bankingAwarenessState']),
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
