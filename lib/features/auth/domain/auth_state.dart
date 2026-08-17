import '../../../core/models/story_model.dart'; // <--- Ruta corregida subiendo 3 niveles

class UserProfile {
  final String id;
  final String email;
  final String name;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
  });
}

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserProfile? user;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserProfile? user,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}