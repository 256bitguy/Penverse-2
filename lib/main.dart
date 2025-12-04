import 'package:penverse/features/subjects/topic/ui/topics_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './core/api/api_client.dart';
import './core/api/api_gateway.dart';
import 'core/theme/app_theme.dart';
import 'core/store/app_store.dart';
import 'core/store/app_state.dart';

import 'features/auth/ui/login_screen.dart';
import './features/entrypoint/entrypoint_ui.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';

import './features/subjects/book/ui/books_list.dart';
import './features/subjects/chapter/ui/chapters_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  // IMPORTANT: Use 10.0.2.2 instead of localhost for Android emulator
  ApiClient().init(baseUrl: 'http://10.0.2.2:5000/api/v1', token: token);

  final apiGateway = ApiGateway.create(); // your existing gateway
  final store = await createStore(apiGateway);

  runApp(MyApp(store: store, apiGateway: apiGateway));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final ApiGateway apiGateway;

  const MyApp({
    super.key,
    required this.store,
    required this.apiGateway,
  });

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
          '/books': (context) => const BooksScreen(),
          '/chapters': (context) => const ChapterListScreen(),
          '/topics': (context) => const TopicsListScreen(),
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
    return const SplashScreen();
  }
}
