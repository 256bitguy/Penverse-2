import 'package:Penverse/features/subjects/book/service/book_service.dart';
import 'package:Penverse/features/subjects/notes/service/notes_service.dart';

import 'api_client.dart';
import '../../features/dailyenglish/vocabulary/services/vocab_service.dart';
import '../../features/dailyenglish/editorials/services/editorials_services.dart';
import '../../features/dailyenglish/phrasalVerbs/services/phrases_services.dart';
import '../../features/dailyenglish/idioms/services/idioms_services.dart';
import '../../features/currentaffairs/generalAwareness/services/bankingAwarenessService.dart';
import '../../features/subjects/subject/service/subject_service.dart';
import '../../features/subjects/topic/service/topic_service.dart';
import '../../features/subjects/chapter/service/chapter_service.dart';
import '../../features/questions/question/service/question_service.dart';

class ApiGateway {
  final VocabService vocabService;
  final EditorialService editorialService;
  final IdiomService idiomService;
  final PhrasalVerbService phrasalVerbService;
  final BankingAwarenessService bankingAwarenessService;

  final SubjectService subjectService;
  final BookService bookService;
  final ChapterService chapterService;
  final TopicService topicService;
  final NotesService notesService;
  final QuestionsService questionService;

  ApiGateway._(
      {required this.vocabService,
      required this.editorialService,
      required this.idiomService,
      required this.phrasalVerbService,
      required this.bankingAwarenessService,
      required this.subjectService,
      required this.bookService,
      required this.chapterService,
      required this.topicService,
      required this.notesService,
      required this.questionService});

  factory ApiGateway.create() {
    final client = ApiClient(); // internally create client
    return ApiGateway._(
        vocabService: VocabService(client),
        editorialService: EditorialService(client),
        idiomService: IdiomService(client),
        phrasalVerbService: PhrasalVerbService(client),
        bankingAwarenessService: BankingAwarenessService(client),
        subjectService: SubjectService(client),
        bookService: BookService(client),
        chapterService: ChapterService(client),
        topicService: TopicService(client),
        notesService: NotesService(client),
        questionService: QuestionsService(client));
  }
}
