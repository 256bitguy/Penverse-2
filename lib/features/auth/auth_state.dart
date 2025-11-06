class AuthState {
  final bool isLoggedIn;
  final String? userEmail;
  final bool isLoading;
   
  final String? errorMessage;

  AuthState({
   required this.isLoading,
    required this.isLoggedIn,
    this.errorMessage,
    required this.userEmail,
     
  });

  factory AuthState.initial() => AuthState(
        isLoading: false,
      isLoggedIn: false,
      errorMessage: null,
        userEmail: null,
      );

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? userEmail,
      String? errorMessage
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoggedIn': isLoggedIn,
        'userEmail': userEmail,
      };

  static AuthState fromJson(Map<String, dynamic> json) => AuthState(
        isLoggedIn: json['isLoggedIn'] ?? false,
        userEmail: json['userEmail'],
        isLoading: json['isLoading'] ?? false,
        errorMessage: json['errorMessage'],
      );
}
