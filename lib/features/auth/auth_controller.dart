import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock_data.dart';
import '../../models/app_user.dart';
import '../../models/user_role.dart';
import 'auth_repository.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthState {
  const AuthState({this.user, this.errorMessage, this.isLoading = false});

  final AppUser? user;
  final String? errorMessage;
  final bool isLoading;

  bool get isAuthenticated => user != null;
  UserRole? get role => user?.role;

  AuthState copyWith({
    AppUser? user,
    bool clearUser = false,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthState(
      user: clearUser ? null : user ?? this.user,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  void signInAs(UserRole role) {
    final user = mockDefaultUserForRole(role);
    state = AuthState(user: user, errorMessage: null);
  }

  Future<AppUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final normalizedEmail = email.trim();
    final normalizedPassword = password.trim();

    if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Preencha e-mail e senha para continuar.',
      );
      return null;
    }

    state = state.copyWith(errorMessage: null, isLoading: true);

    final AppUser? user;
    try {
      user = await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(
            email: normalizedEmail,
            password: normalizedPassword,
          );
    } catch (_) {
      state = state.copyWith(
        clearUser: true,
        isLoading: false,
        errorMessage:
            'Não encontramos esse acesso. Revise os dados e tente novamente.',
      );
      return null;
    }

    if (user == null) {
      state = state.copyWith(
        clearUser: true,
        isLoading: false,
        errorMessage:
            'Não encontramos esse acesso. Revise os dados e tente novamente.',
      );
      return null;
    }

    state = AuthState(user: user, errorMessage: null, isLoading: false);
    return user;
  }

  void clearError() {
    if (state.errorMessage == null) {
      return;
    }
    state = state.copyWith(errorMessage: null);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthState();
  }
}
