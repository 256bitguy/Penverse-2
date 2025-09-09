
 
import 'package:Penverse/features/questions/question/reduxx/questions_reducer.dart';
import 'package:Penverse/features/subjects/book/redux/book_reducer.dart';
import 'package:Penverse/features/subjects/chapter/redux/chapter_reducer.dart';
import 'package:Penverse/features/subjects/notes/redux/notes_reducer.dart';
import 'package:Penverse/features/subjects/subject/redux/subject_reducer.dart';

import '../../features/auth/auth_reducers.dart';
import '../../features/dailyenglish/vocabulary/vocab_reducer.dart';
import '../../features/dailyenglish/idioms/idioms_reducer.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_reducer.dart';
import '../../features/dailyenglish/editorials/editorial_reducer.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_reducer.dart';  
import '../../features/currentaffairs/upscAwareness/upsc_reducer.dart';  
import '../../features/subjects/topic/redux/topic_reducer.dart';
 
import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
    vocabState: vocabReducer(state.vocabState, action),
    idiomsState: idiomsReducer(state.idiomsState, action),
    phrasalVerbsState: phrasalVerbsReducer(state.phrasalVerbsState, action),
    editorialState: editorialReducer(state.editorialState, action),
    bankingAwarenessState:
        bankingAwarenessReducer(state.bankingAwarenessState, action),
        upscAwarenessState:
        upscAwarenessReducer(state.upscAwarenessState, action),
    subjectState: subjectReducer(state.subjectState, action),
    bookState: bookReducer(state.bookState, action),
    chapterState: chapterReducer(state.chapterState, action),
    topicState:  topicReducer(state.topicState, action),
    notesState: notesReducer(state.notesState, action),
    questionsState: questionsReducer(state.questionsState, action)
 
  );
}
