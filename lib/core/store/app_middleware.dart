import 'package:redux/redux.dart';
import '../../core/store/app_state.dart';
import '../../core/api/api_gateway.dart';

// Import feature actions
import '../../features/dailyenglish/vocabulary/vocab_actions.dart';
import '../../features/dailyenglish/editorials/editorial_actions.dart';
import '../../features/dailyenglish/idioms/idioms_actions.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verbs_actions.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_actions.dart';

List<Middleware<AppState>> createAppMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, LoadVocabAction>(_fetchVocab(apiGateway)),
    TypedMiddleware<AppState, LoadEditorialAction>(
        _fetchEditorials(apiGateway)),
    TypedMiddleware<AppState, LoadIdiomsAction>(_fetchIdioms(apiGateway)),
    TypedMiddleware<AppState, LoadPhrasalVerbsAction>(
        _fetchPhrasalVerbs(apiGateway)),
    TypedMiddleware<AppState, LoadBankingAwarenessAction>(
        _fetchBankingAwareness(apiGateway)),
  ];
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
