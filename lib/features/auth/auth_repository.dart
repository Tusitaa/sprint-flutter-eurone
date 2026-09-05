import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock_data.dart';
import '../../models/app_user.dart';

/// Fornece a implementação de autenticação usada pelo app.
///
/// O MVP roda 100% com dados mockados, portanto não há integração com
/// backend, banco de dados ou serviços externos.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => MockAuthRepository(),
);

/// Contrato de autenticação. Manter a interface facilita evoluir para um
/// backend real no futuro sem alterar as telas.
abstract interface class AuthRepository {
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

/// Autenticação simulada: valida e-mail e senha contra a lista de usuários
/// mock definida em [mockUsers].
class MockAuthRepository implements AuthRepository {
  @override
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Pequena latência para simular uma chamada de rede real.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return mockUserFromCredentials(email, password);
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }
}
