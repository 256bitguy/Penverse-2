import 'package:redux/redux.dart';
import '../../core/store/app_state.dart';
import '../../core/api/api_gateway.dart';

// Import feature actions
import '../../features/dailyenglish/vocabulary/vocab_actions.dart';
import '../../features/dailyenglish/editorials/editorial_actions.dart';
import '../../features/dailyenglish/idioms/idioms_actions.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verbs_actions.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_actions.dart';
import '../../features/subjects/subject/redux/subject_actions.dart';
import '../../features/subjects/book/redux/book_actions.dart';
import '../../features/subjects/chapter/redux/chapter_actions.dart';
import '../../features/subjects/topic/redux/topic_action.dart';

List<Middleware<AppState>> createAppMiddleware(ApiGateway apiGateway) {
  print("third");
  return [
    TypedMiddleware<AppState, LoadVocabAction>(_fetchVocab(apiGateway)),
    TypedMiddleware<AppState, LoadEditorialAction>(
        _fetchEditorials(apiGateway)),
    TypedMiddleware<AppState, LoadIdiomsAction>(_fetchIdioms(apiGateway)),
    TypedMiddleware<AppState, LoadPhrasalVerbsAction>(
        _fetchPhrasalVerbs(apiGateway)),
    TypedMiddleware<AppState, LoadBankingAwarenessAction>(
        _fetchBankingAwareness(apiGateway)),
    TypedMiddleware<AppState, LoadSubjectsAction>(_loadSubjects(apiGateway)),
    TypedMiddleware<AppState, LoadBooksBySubjectAction>(
        _loadBooksBySubject(apiGateway)),
    TypedMiddleware<AppState, LoadChaptersByBookAction>(
        _loadChaptersByBooks(apiGateway)),
         TypedMiddleware<AppState, LoadTopicsByChapterAction>(
        _loadTopicsByChapters(apiGateway)),
  ];
}

Middleware<AppState> _loadTopicsByChapters(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadTopicsByChapterAction) {
      next(action); // Pass the action to the next middleware/reducer

      try {
        final response =
            await apiGateway.topicService.fetchTopicsByChapter(action.chapterId);
        store.dispatch(LoadTopicsSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadTopicsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _loadChaptersByBooks(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadChaptersByBookAction) {
      next(action); // Pass the action to the next middleware/reducer

      try {
        final response =
            await apiGateway.chapterService.fetchChaptersByBook(action.bookId);
        store.dispatch(LoadChaptersSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadChaptersFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _loadBooksBySubject(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadBooksBySubjectAction) {
      next(action); // Pass the action to the next middleware/reducer

      try {
        final response =
            await apiGateway.bookService.fetchBooksBySubject(action.subjectId);
        store.dispatch(LoadBooksSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadBooksFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _loadSubjects(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadSubjectsAction) {
      next(action); // Pass the action to the next middleware/reducer

      try {
        final response = await apiGateway.subjectService.fetchSubjects();
        store.dispatch(LoadSubjectsSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadSubjectsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchBankingAwareness(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadBankingAwarenessAction) {
      next(action);

      try {
        final response =
            await apiGateway.bankingAwarenessService.getDailyBankingAwareness();

        store.dispatch(LoadBankingAwarenessSuccessAction(response));
      } catch (error) {
        store.dispatch(LoadBankingAwarenessFailureAction(error.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchVocab(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadVocabAction) {
      next(action); // Pass action to reducer first

      try {
        final response = await apiGateway.vocabService.getDailyVocab();

        store.dispatch(LoadVocabSuccessAction(response));
      } catch (error) {
        store.dispatch(LoadVocabFailureAction(error.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchEditorials(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadEditorialAction) {
      try {
        final response = await apiGateway.editorialService.getDailyEditorials();

        store.dispatch(LoadEditorialSuccessAction(response));
      } catch (error) {
        store.dispatch(LoadEditorialFailureAction(error.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchIdioms(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    try {
      final response = await apiGateway.idiomService.getDailyIdioms();

      store.dispatch(LoadIdiomsSuccessAction(response));
    } catch (error) {
      store.dispatch(LoadIdiomsFailureAction(error.toString()));
    }
  };
}

Middleware<AppState> _fetchPhrasalVerbs(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadPhrasalVerbsAction) {
      try {
        final response =
            await apiGateway.phrasalVerbService.getDailyPhrasalVerbs();

        store.dispatch(LoadPhrasalVerbsSuccessAction(response));
      } catch (error) {
        store.dispatch(LoadPhrasalVerbsFailureAction(error.toString()));
      }
    } else {
      next(action);
    }
  };
}
