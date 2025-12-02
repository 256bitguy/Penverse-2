import 'package:penverse/features/auth/services/auth_actions.dart';
import 'package:redux/redux.dart';
import '../../core/store/app_state.dart';
import '../../core/api/api_gateway.dart';

// Feature Actions
import '../../features/dailyenglish/vocabulary/vocab_actions.dart';
import '../../features/dailyenglish/editorials/editorial_actions.dart';
import '../../features/dailyenglish/idioms/idioms_actions.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verbs_actions.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_actions.dart';
import '../../features/subjects/Library/redux/section_actions.dart';
import '../../features/subjects/book/redux/book_actions.dart';
import '../../features/subjects/chapter/redux/chapter_actions.dart';
import '../../features/subjects/topic/redux/topic_action.dart';
import '../../features/subjects/notes/redux/notes_action.dart';
import '../../features/questions/question/reduxx/question_action.dart';
import '../../features/questions/quiz/redux/quiz_action.dart';

List<Middleware<AppState>> createAppMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, RegisterAction>(_Register(apiGateway)),
    TypedMiddleware<AppState, LoginAction>(_Login(apiGateway)),


    TypedMiddleware<AppState, LoadVocabAction>(_fetchVocab(apiGateway)),
    TypedMiddleware<AppState, LoadVocabByDateAction>(_fetchVocab(apiGateway)),
    TypedMiddleware<AppState, LoadEditorialAction>(
        _fetchEditorials(apiGateway)),
    TypedMiddleware<AppState, LoadEditorialByDateAction>(
        _fetchEditorials(apiGateway)),
    TypedMiddleware<AppState, LoadIdiomsAction>(_fetchIdioms(apiGateway)),
    TypedMiddleware<AppState, LoadPhrasalVerbsAction>(
        _fetchPhrasalVerbs(apiGateway)),
    TypedMiddleware<AppState, FetchAwarenessByDateAction>(
        _fetchBankingAwareness(apiGateway)),
    TypedMiddleware<AppState, LoadSectionsAction>(_loadSections(apiGateway)),
    TypedMiddleware<AppState, LoadBooksBySubjectAction>(
        _loadBooksBySubject(apiGateway)),
    TypedMiddleware<AppState, LoadChaptersByBookAction>(
        _loadChaptersByBooks(apiGateway)),
    TypedMiddleware<AppState, LoadTopicsByChapterAction>(
        _loadTopicsByChapters(apiGateway)),

    // Topic-specific middlewares
    TypedMiddleware<AppState, FetchNoteByTopicIdAction>(
        _fetchNoteByTopic(apiGateway)),
    TypedMiddleware<AppState, FetchVocabByTopicIdAction>(
        _fetchVocabByTopic(apiGateway)),
    TypedMiddleware<AppState, FetchIdiomsByTopicIdAction>(
        _fetchIdiomsByTopic(apiGateway)),
    TypedMiddleware<AppState, FetchPhrasesByTopicIdAction>(
        _fetchPhrasesByTopic(apiGateway)),
    // TypedMiddleware<AppState, FetchAwarenessByTopicIdAction>(
    //     _fetchAwarenessByTopic(apiGateway)),

    TypedMiddleware<AppState, FetchQuestionsByTopicIdAction>(
        _fetchQuestionByTopic(apiGateway)),
    TypedMiddleware<AppState, FetchAllQuizzesAction>(
        _fetchQuestionSetListByNotes(apiGateway)),
    TypedMiddleware<AppState, FetchQuizByIdAction>(
        _fetchQuizSetListByQuizId(apiGateway)),
  ];
}


Middleware<AppState> _Register(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is RegisterAction) {
      next(action);
      try {
        print(  "Register Middleware: RegisterAction received with email: ${action.email}");
        final response =
            await apiGateway.authService.register(email: action.email, password: action.password);
        store.dispatch(RegisterSuccessAction(response));
      } catch (e) {
        store.dispatch(RegisterFailureAction(e.toString()));
      }
    }
    // ✅ Handle fetching a single quiz by ID
    else {
      next(action);
    }
  };
}
Middleware<AppState> _Login(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoginAction) {
      next(action); // sets isLoading = true in reducer
      try {
        // print("Login Middleware: LoginAction received with email: ${action.email}");

        final backendResponse = await apiGateway.authService.login(
          email: action.email,
          password: action.password,
        );
print(  "Login Middleware: Received backend response: $backendResponse  ");
        // final response = {
        //   // "userId": backendResponse["data"]["user"]["_id"],
        //   "accessToken": backendResponse["data"]["accessToken"],
        //   "refreshToken": backendResponse["data"]["refreshToken"],
        // };

        store.dispatch(LoginSuccessAction(backendResponse));
      } catch (e) {
        store.dispatch(LoginFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}



Middleware<AppState> _fetchQuestionSetListByNotes(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchAllQuizzesAction) {
      next(action);
      try {
        final response =
            await apiGateway.quizService.fetchQuizzesByTopicId(action.topicId);
        store.dispatch(FetchAllQuizzesSuccessAction(response));
      } catch (e) {
        store.dispatch(FetchQuestionsFailureAction(e.toString()));
      }
    }
    // ✅ Handle fetching a single quiz by ID
    else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchQuizSetListByQuizId(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchQuizByIdAction) {
      next(action);
      try {
        print(action.quizId);
        final response =
            await apiGateway.quizService.fetchQuizById(action.quizId);
        store.dispatch(FetchQuizByIdSuccessAction(response));
      } catch (e) {
        store.dispatch(FetchQuizFailureAction(e.toString()));
      }
    }
    // ✅ Handle fetching a single quiz by ID
    else {
      next(action);
    }
  };
}

// ---------------- Topic-specific middlewares ----------------
Middleware<AppState> _fetchQuestionByTopic(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchQuestionsByTopicIdAction) {
      next(action);
      try {
        final response = await apiGateway.questionService
            .fetchQuestionsByTopicId(action.topicId);
        store.dispatch(FetchQuestionsSuccessAction(response));
      } catch (e) {
        store.dispatch(FetchQuestionsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchNoteByTopic(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchNoteByTopicIdAction) {
      next(action);
      try {
        final response =
            await apiGateway.notesService.fetchNoteById(action.topicId);
        store.dispatch(FetchNoteSuccessAction(response));
      } catch (e) {
        store.dispatch(FetchNoteFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchVocabByTopic(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchVocabByTopicIdAction) {
      next(action);
      try {
        final response =
            await apiGateway.vocabService.fetchVocabByTopic(action.topicId);
        store.dispatch(LoadVocabSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadVocabFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchIdiomsByTopic(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchIdiomsByTopicIdAction) {
      next(action);
      try {
        final response =
            await apiGateway.idiomService.fetchIdiomsByTopic(action.topicId);
        store.dispatch(LoadIdiomsSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadIdiomsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchPhrasesByTopic(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchPhrasesByTopicIdAction) {
      next(action);
      try {
        final response = await apiGateway.phrasalVerbService
            .fetchPhrasesByTopic(action.topicId);
        store.dispatch(LoadPhrasalVerbsSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadPhrasalVerbsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

 
Middleware<AppState> _loadSections(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadSectionsAction) {
      next(action);
      try {
        final response = await apiGateway.subjectService.fetchSubjects();
        store.dispatch(LoadSectionsSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadSectionsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _loadBooksBySubject(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadBooksBySubjectAction) {
      next(action);
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

Middleware<AppState> _loadChaptersByBooks(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadChaptersByBookAction) {
      next(action);
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

Middleware<AppState> _loadTopicsByChapters(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadTopicsByChapterAction) {
      next(action);
      try {
        final response = await apiGateway.topicService
            .fetchTopicsByChapter(action.chapterId);
        store.dispatch(LoadTopicsSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadTopicsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchVocab(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadVocabAction) {
      next(action);
      try {
        final response = await apiGateway.vocabService.getDailyVocab();
        store.dispatch(LoadVocabSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadVocabFailureAction(e.toString()));
      }
    } else if (action is LoadVocabByDateAction) {
      try {
        final response =
            await apiGateway.vocabService.getVocabByDate(action.date);
        store.dispatch(LoadVocabSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadVocabFailureAction(e.toString()));
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
      } catch (e) {
        store.dispatch(LoadEditorialFailureAction(e.toString()));
      }
    } else if (action is LoadEditorialByDateAction) {
      try {
        final response =
            await apiGateway.editorialService.getEditorialByDate(action.date);
        store.dispatch(LoadEditorialSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadEditorialFailureAction(e.toString()));
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
    } catch (e) {
      store.dispatch(LoadIdiomsFailureAction(e.toString()));
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
      } catch (e) {
        store.dispatch(LoadPhrasalVerbsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _fetchBankingAwareness(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchAwarenessByDateAction) {
      // next(action);
      try {
        final response = await apiGateway.bankingAwarenessService
            .getDailyBankingAwareness(action.date);
        store.dispatch(LoadBankingAwarenessSuccessAction(response));
      } catch (e) {
        store.dispatch(LoadBankingAwarenessFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}
