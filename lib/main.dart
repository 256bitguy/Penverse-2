import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './core/api/api_client.dart';
import './core/api/api_gateway.dart';
import 'core/theme/app_theme.dart';
import 'core/store/app_store.dart';
import 'core/store/app_state.dart';
import './core/api/api_endpoints.dart';
import 'features/auth/ui/login_screen.dart';
import './features/entrypoint/entrypoint_ui.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';
import './features/dailyenglish/vocabulary/vocab_actions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient().init(baseUrl: 'http://localhost:8000', authToken: '1234');


 final apiGateway = ApiGateway.create();
 

  final store = await createStore(apiGateway);
  
  runApp(MyApp(store: store, apiGateway: apiGateway));}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final ApiGateway apiGateway;

  const MyApp({super.key, required this.store, required this.apiGateway,});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Penverse',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => AuthWrapper(apiGateway: apiGateway),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const EntryPointUI(),
        },
      ),
    );
  }
}
class AuthWrapper extends StatelessWidget {
  final ApiGateway apiGateway;

  const AuthWrapper({super.key, required this.apiGateway});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (store) => store.state.authState.isLoggedIn,
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          return const EntryPointUI();
        }
        return const SplashScreen();
      },
    );
  }
}

