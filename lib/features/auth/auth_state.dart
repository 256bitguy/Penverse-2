class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final bool isRegistered;
  final String? userEmail;
  final String? userId;
  final String? accessToken;
  final String? refreshToken;

  final String? errorMessage;

  const AuthState({
    required this.isLoading,
    required this.isLoggedIn,
    required this.isRegistered,
    this.userEmail,
    this.userId,
    this.accessToken,
    this.refreshToken,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    bool? isRegistered,
 
    String? userId,
    String? accessToken,
    String? refreshToken,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isRegistered: isRegistered ?? this.isRegistered,
      userId: userId ?? this.userId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      errorMessage: errorMessage,
    );
  }
  Map<String, dynamic> toJson() => {
        'isLoggedIn': isLoggedIn,
        'isRegistered': isRegistered,
        'accessToken': accessToken,
        'userId': userId,
      };

  factory AuthState.initial() => const AuthState(
        isLoading: false,
        isLoggedIn: false,
        isRegistered: false,
        userId: null,
        accessToken: null,
        refreshToken: null,
        errorMessage: null,
      );
  static AuthState fromJson(Map<String, dynamic> json) => AuthState(
        isLoggedIn: json['isLoggedIn'] ?? false,
        userEmail: json['userEmail'],
        userId: json['userId'],
        accessToken: json['accessToken'],
        isRegistered: json['isRegistered'] ?? false,
        isLoading: json['isLoading'] ?? false,
        errorMessage: json['errorMessage'],
      );
}

