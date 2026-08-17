import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulación de autenticación segura (remplazar por petición HTTPS a backend o Firebase Auth)
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'user@noxstories.com' && password == 'NoxPass2026!') {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: const UserProfile(
          id: 'usr_01',
          email: 'user@noxstories.com',
          name: 'Viajero Nocturno',
        ),
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Credenciales inválidas. Comprueba tu correo y contraseña.',
      );
      return false;
    }
  }

  void logout() {
    state = const AuthState();
  }
}