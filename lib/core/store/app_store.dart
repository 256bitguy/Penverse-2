import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:penverse/features/home/services/home/payment_middleware.dart';
import 'package:penverse/features/home/services/search/search_middleware.dart';
import 'package:penverse/features/subjects/Library/redux/purchased/purchased_middleware.dart';
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

  final store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState.initial(),
    middleware: [
      persistor.createMiddleware(),
      ...createAppMiddleware(apiGateway),
      ...createSearchMiddleware(apiGateway.searchService),
      ...createPaymentMiddleware(apiGateway.paymentService),
      ...createPurchasedMiddleware(apiGateway.purchasedService),
    ],
  );

  return store;
}
