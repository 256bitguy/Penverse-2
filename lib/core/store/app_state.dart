import 'package:penverse/features/home/services/home/payment_state.dart';
import 'package:penverse/features/home/services/search/search_state.dart';
import 'package:penverse/features/subjects/Library/redux/library/library_state.dart';
import 'package:penverse/features/subjects/Library/redux/purchased/purchased_books_state.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_books_state.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_model.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_state.dart';
import 'package:penverse/features/subjects/book/redux/book_state.dart';

import '../../features/auth/services/auth_state.dart';
import '../../features/dailyenglish/vocabulary/vocab_state.dart';
import '../../features/dailyenglish/idioms/idioms_state.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_state.dart';
import '../../features/dailyenglish/editorials/editorial_state.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_state.dart';
import '../../features/currentaffairs/upscAwareness/upsc_state.dart' as upsc;

import '../../features/subjects/chapter/redux/chapter_state.dart';
import '../../features/subjects/topic/redux/topic_state.dart';
import '../../features/subjects/notes/redux/notes_state.dart';
import '../../features/questions/question/reduxx/question_state.dart';
import '../../features/questions/quiz/redux/quiz_state.dart';
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AuthState authState;
  final VocabState vocabState;
  final IdiomsState idiomsState;
  final PhrasalVerbsState phrasalVerbsState;
  final EditorialState editorialState;
  final BankingAwarenessState bankingAwarenessState;
  final upsc.UpscAwarenessState upscAwarenessState;

  final BookState bookState;
  final SearchState searchState;
  final ChapterState chapterState;
  final TopicState topicState;
  final NotesState notesState;
  final QuestionsState questionsState;
  final QuizState quizState;
  final PaymentState paymentState;
  final PurchasedBooksState purchasedBookState;
  final LibraryState libraryState;
  final SectionState sectionState;
  final SectionBooksState sectionBooksState;

  const AppState(
      {required this.authState,
      required this.vocabState,
      required this.idiomsState,
      required this.phrasalVerbsState,
      required this.editorialState,
      required this.bankingAwarenessState,
      required this.upscAwarenessState,
      required this.bookState,
      required this.searchState,
      required this.chapterState,
      required this.topicState,
      required this.notesState,
      required this.questionsState,
      required this.quizState,
      required this.paymentState,
      required this.purchasedBookState,
      required this.libraryState,
      required this.sectionState,
      required this.sectionBooksState});

  factory AppState.initial() => AppState(
      authState: AuthState.initial(),
      vocabState: VocabState.initial(),
      idiomsState: IdiomsState.initial(),
      phrasalVerbsState: PhrasalVerbsState.initial(),
      editorialState: EditorialState.initial(),
      bankingAwarenessState: BankingAwarenessState.initial(),
      upscAwarenessState: upsc.UpscAwarenessState.initial(),
      bookState: BookState.initial(),
      searchState: SearchState.initial(),
      chapterState: ChapterState.initial(),
      topicState: TopicState.initial(),
      notesState: NotesState.initial(),
      questionsState: QuestionsState.initial(),
      quizState: QuizState.initial(),
      paymentState: PaymentState.initial(),
      purchasedBookState: PurchasedBooksState.initial(),
      libraryState: LibraryState.initial(),
      sectionState: SectionState.initial(),
      sectionBooksState: SectionBooksState.initial());

  AppState copyWith({
    AuthState? authState,
    VocabState? vocabState,
    IdiomsState? idiomsState,
    PhrasalVerbsState? phrasalVerbsState,
    EditorialState? editorialState,
    BankingAwarenessState? bankingAwarenessState,
    upsc.UpscAwarenessState? upscAwarenessState,
    BookState? bookState,
    SearchState? searchState,
    NotesState? notesState,
    ChapterState? chapterState,
    TopicState? topicState,
    QuestionsState? questionsState,
    QuizState? quizState,
    PaymentState? paymentState,
    LibraryState? libraryState,
    SectionState? sectionState,
    SectionBooksState? sectionBooksState
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
        bookState: bookState ?? this.bookState,
        searchState: searchState ?? this.searchState,
        chapterState: chapterState ?? this.chapterState,
        topicState: topicState ?? this.topicState,
        notesState: notesState ?? this.notesState,
        questionsState: questionsState ?? this.questionsState,
        quizState: quizState ?? this.quizState,
        paymentState: paymentState ?? this.paymentState,
        purchasedBookState: purchasedBookState,
        libraryState: libraryState ?? this.libraryState,
        sectionState: sectionState ?? this.sectionState,
        sectionBooksState: sectionBooksState ?? this.sectionBooksState);
  }

  Map<String, dynamic> toJson() => {
        'authState': authState.toJson(),
        'vocabState': vocabState.toJson(),
        'idiomsState': idiomsState.toJson(),
        'phrasalVerbsState': phrasalVerbsState.toJson(),
        'editorialState': editorialState.toJson(),
        'bankingAwarenessState': bankingAwarenessState.toJson(),
        'upscAwarenessState': upscAwarenessState.toJson(),
        'questionsState': questionsState.toJson(),
        'quizState': quizState.toJson(),
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
        bookState: BookState.fromJson(json['bookState']),
        searchState: SearchState.fromJson(json['searchState']),
        chapterState: ChapterState.fromJson(json['chapterState']),
        topicState: TopicState.fromJson(json['topicState']),
        notesState: NotesState.fromJson(json['notesState']),
        questionsState: QuestionsState.fromJson(json['questionsState']),
        quizState: QuizState.fromJson(json['quizState']),
        paymentState: PaymentState.fromJson(json['paymentState']),
        purchasedBookState:
            PurchasedBooksState.fromJson(json['purchasedState']),
        libraryState: LibraryState.fromJson(json['libraryState']),
        sectionState: SectionState.fromJson(json['sectionState']),
        sectionBooksState: SectionBooksState.fromJson(json["sectionBooksState"]));
  }

  @override
  List<Object?> get props => [
        authState,
        vocabState,
        idiomsState,
        phrasalVerbsState,
        editorialState,
        searchState,
        bankingAwarenessState,
        upscAwarenessState,
        topicState,
        questionsState,
        quizState,
        paymentState,
        purchasedBookState,
        sectionState
      ];
}
