import 'package:Penverse/features/subjects/book/redux/book_state.dart';

import '../../features/auth/auth_state.dart';
import '../../features/dailyenglish/vocabulary/vocab_state.dart';
import '../../features/dailyenglish/idioms/idioms_state.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_state.dart';
import '../../features/dailyenglish/editorials/editorial_state.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_state.dart';
import '../../features/currentaffairs/upscAwareness/upsc_state.dart' as upsc;
import '../../features/subjects/subject/redux/subject_state.dart';
import '../../features/subjects/chapter/redux/chapter_state.dart';
import '../../features/subjects/topic/redux/topic_state.dart';
import '../../features/subjects/notes/redux/notes_state.dart';
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AuthState authState;
  final VocabState vocabState;
  final IdiomsState idiomsState;
  final PhrasalVerbsState phrasalVerbsState;
  final EditorialState editorialState;
  final BankingAwarenessState bankingAwarenessState;
  final upsc.UpscAwarenessState upscAwarenessState;
  final SubjectState subjectState;
  final BookState bookState;
  final ChapterState chapterState;
  final TopicState topicState;
  final NotesState notesState;

  const AppState(
      {required this.authState,
      required this.vocabState,
      required this.idiomsState,
      required this.phrasalVerbsState,
      required this.editorialState,
      required this.bankingAwarenessState,
      required this.upscAwarenessState,
      required this.subjectState,
      required this.bookState,
      required this.chapterState,
      required this.topicState,
      required this.notesState});

  factory AppState.initial() => AppState(
      authState: AuthState.initial(),
      vocabState: VocabState.initial(),
      idiomsState: IdiomsState.initial(),
      phrasalVerbsState: PhrasalVerbsState.initial(),
      editorialState: EditorialState.initial(),
      bankingAwarenessState: BankingAwarenessState.initial(),
      upscAwarenessState: upsc.UpscAwarenessState.initial(),
      subjectState: SubjectState.initial(),
      bookState: BookState.initial(),
      chapterState: ChapterState.initial(),
      topicState: TopicState.initial(),
      notesState: NotesState.initial());

  AppState copyWith({
    AuthState? authState,
    VocabState? vocabState,
    IdiomsState? idiomsState,
    PhrasalVerbsState? phrasalVerbsState,
    EditorialState? editorialState,
    BankingAwarenessState? bankingAwarenessState,
    upsc.UpscAwarenessState? upscAwarenessState,
    BookState?bookState,
    SubjectState ? subjectState,
    NotesState ? notesState,
    ChapterState ? chapterState,
    TopicState ? topicState
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
        subjectState: subjectState ?? this.subjectState,
        bookState: bookState ?? this.bookState,
        chapterState: chapterState ?? this.chapterState,
        topicState: topicState ?? this.topicState,
        notesState: notesState??this.notesState);
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
        'subjectState': subjectState.toJson(),
      };

  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();

    return AppState(
        authState: AuthState.fromJson(json['authState']),
        vocabState: VocabState.fromJson(json['vocabState']),
        idiomsState: IdiomsState.fromJson(json['idiomsState']),
        phrasalVerbsState:
            PhrasalVerbsState.fromJson(json['phrasalVerbsState']),
        editorialState: EditorialState.fromJson(json['editorialState']),
        bankingAwarenessState:
            BankingAwarenessState.fromJson(json['bankingAwarenessState']),
        upscAwarenessState:
            upsc.UpscAwarenessState.fromJson(json['upscAwarenessState']),
        subjectState: SubjectState.fromJson(json['subjectState']),
        bookState: BookState.fromJson(json['bookState']),
        chapterState: ChapterState.fromJson(json['chapterState']),
        topicState: TopicState.fromJson(json['topicState']),
        notesState: NotesState.fromJson(json['notesState']));
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
        topicState
      ];
}
