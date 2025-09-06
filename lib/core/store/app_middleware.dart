import 'package:redux/redux.dart';
import '../../core/store/app_state.dart';
import '../../core/api/api_gateway.dart';

// Import feature actions
import '../../features/dailyenglish/vocabulary/vocab_actions.dart';
import '../../features/dailyenglish/editorials/editorial_actions.dart';
import '../../features/dailyenglish/idioms/idioms_actions.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verbs_actions.dart';

List<Middleware<AppState>> createAppMiddleware(ApiGateway apiGateway) {
  // print("🔥 App middleware initialized with a $apiGateway");
  // print("third");
  return [
    TypedMiddleware<AppState, LoadVocabAction>(_fetchVocab(apiGateway)),
    TypedMiddleware<AppState, LoadEditorialAction>(
        _fetchEditorials(apiGateway)),
    TypedMiddleware<AppState, LoadIdiomsAction>(_fetchIdioms(apiGateway)),
    TypedMiddleware<AppState, LoadPhrasalVerbsAction>(
        _fetchPhrasalVerbs(apiGateway)),
  ];
}

Middleware<AppState> _fetchVocab(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadVocabAction) {
      // print("🟡 Middleware received LoadVocabAction");

      next(action); // Pass action to reducer first

      try {
        print("🌍 Fetching vocab from API...");
        final response = await apiGateway.vocabService.getDailyVocab();
        print("✅ API fetch success. Dispatching LoadVocabSuccessAction");
        store.dispatch(LoadVocabSuccessAction(response));
      } catch (error) {
        print("❌ API fetch failed: $error");
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
        print("action has been picked up editorial verb");
        final response = await apiGateway.editorialService.getDailyEditorials();
         print("see here:-  $response");
        store.dispatch(LoadEditorialSuccessAction(response));
      } catch (error) {
         print("ye error to hai hi apna $error");
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
      // print("🌍 Fetching idioms from API...");
      final response = await apiGateway.idiomService.getDailyIdioms();
      // print("✅ API fetch success. Dispatching LoadVocabSuccessAction");

      store.dispatch(LoadIdiomsSuccessAction(response));
    } catch (error) {
      // print("sixth");
// print("❌ API fetch failed: $error");
      store.dispatch(LoadIdiomsFailureAction(error.toString()));
    }
  };
}

Middleware<AppState> _fetchPhrasalVerbs(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadPhrasalVerbsAction) {
      try {
        print("action has been picked up phrasal verb");
        final response =
            await apiGateway.phrasalVerbService.getDailyPhrasalVerbs();
        print("see here:-  $response");
        store.dispatch(LoadPhrasalVerbsSuccessAction(response));
      } catch (error) {
        print("ye error to hai hi apna $error");
        store.dispatch(LoadPhrasalVerbsFailureAction(error.toString()));
      }
    } else {
      next(action);
    }
  };
}
