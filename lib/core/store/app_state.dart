import '../../features/auth/auth_state.dart';

class AppState {
  final AuthState authState ;

  AppState({
    required this.authState,
  });

  // initial state
  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
    );
  }

  // copyWith (helps immutability)
  AppState copyWith({
    AuthState? authState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
    );
  }

  // for persistence
  static AppState fromJson(dynamic json) {
    if (json == null) return AppState.initial();
    return AppState(
      authState: AuthState.fromJson(json['authState']),
    );
  }

  dynamic toJson() => {
        'authState': authState.toJson(),
      };
}
