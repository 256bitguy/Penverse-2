import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux/redux.dart';
// import '../../features/dailyenglish/vocabulary/vocab_actions.dart';
// import '../../features/dailyenglish/editorials/editorial_actions.dart';
// import '../../features/dailyenglish/idioms/idioms_actions.dart';
// import '../../features/dailyenglish/phrasalVerbs/phrasal_verbs_actions.dart';
import 'app_state.dart';
import 'app_reducer.dart';
import '../api/api_gateway.dart';
import '../store/app_middleware.dart';

Future<Store<AppState>> createStore(ApiGateway apiGateway) async {
  //  print("📦 createStore started with ApiGateway: $apiGateway"); 
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(
      location: kIsWeb
          ? FlutterSaveLocation.sharedPreferences
          : FlutterSaveLocation.documentFile,
    ),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true,
  );

  final initialState = await persistor.load();
  // print("📂 Initial state loaded: $initialState");
 final store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState.initial(),
    middleware: [
      persistor.createMiddleware(),
      ...createAppMiddleware(apiGateway),
    ],
  );

  // print("✅ Store created successfully");
  return store;

}
