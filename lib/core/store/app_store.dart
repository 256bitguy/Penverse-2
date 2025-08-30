import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux/redux.dart';
import 'app_state.dart';  // adjust to your AppState import
import 'app_reducer.dart'; // adjust to your reducer

Future<Store<AppState>> createStore() async {
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

  return Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState.initial(),
    middleware: [persistor.createMiddleware()],
  );
}
