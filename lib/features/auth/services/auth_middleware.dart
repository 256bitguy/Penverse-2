// import 'package:redux/redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../core/store/app_state.dart';
// import 'auth_actions.dart';
 

// List<Middleware<AppState>> createAuthMiddleware() {
//   return [
//     TypedMiddleware<AppState, InitializeAuth>(_initializeAuth()),
//     TypedMiddleware<AppState, RegisterAction>(_register()),
//     TypedMiddleware<AppState, LoginAction>(_login()),
//     TypedMiddleware<AppState, Logout>(_logout()),
//   ];
// }

// Middleware<AppState> _initializeAuth() {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     next(action);
//     final prefs = await SharedPreferences.getInstance();
//     final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//     final userEmail = prefs.getString('userEmail');

//     if (isLoggedIn && userEmail != null) {
//       store.dispatch(LoginSuccessAction({'email': userEmail}));
//     }
//   };
// }

// Middleware<AppState> _register() {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     next(action);
//     if (action is RegisterAction) {
      
//       await Future.delayed(const Duration(seconds: 1));
    
//       store.dispatch(LoginAction(action.email, action.password));
//     }
//   };
// }

// Middleware<AppState> _login() {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     next(action);
//     if (action is LoginAction) {
//       await Future.delayed(const Duration(seconds: 1)); // simulate API call
//       if (action.email.isNotEmpty && action.password.isNotEmpty) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', true);
//         await prefs.setString('userEmail', action.email);

//         store.dispatch(LoginSuccessAction({'email': action.email}));
//       } else {
//         store.dispatch(LoginFailureAction("Invalid credentials"));
//       }
//     }
//   };
// }

// Middleware<AppState> _logout() {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     next(action);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     await prefs.remove('userEmail');
//   };
// }
