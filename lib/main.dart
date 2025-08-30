import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'core/theme/app_theme.dart';
import 'core/store/app_store.dart';
import 'core/store/app_state.dart';
import 'features/auth/ui/login_screen.dart';
import './features/entrypoint/entrypoint_ui.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';
import './features/dailyenglish/vocabulary/ui/daily_vocab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create the Redux store (with persistence)
  final Store<AppState> store = await createStore();

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Penverse',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const EntryPointUI(),
          '/vocab': (context) => const DailyVocabScreen()
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

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
