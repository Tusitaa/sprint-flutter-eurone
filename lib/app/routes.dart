import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/models/user_role.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/login_screen.dart';
import '../features/educador/alunos/aluno_detail_screen.dart';
import '../features/educador/educador_shell.dart';
import '../features/educando/cursos/curso_detail_screen.dart';
import '../features/educando/cursos/forum_detail_screen.dart';
import '../features/educando/educando_shell.dart';
import '../features/gestao/gestao_shell.dart';
import '../features/gestao/professores/professor_detail_screen.dart';
import '../features/shared_detail/turma_detail_screen.dart';
import '../features/splash/splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // Reexecuta a lógica de redirect sempre que a autenticação muda, sem
  // recriar o GoRouter (o que reiniciaria a navegação).
  final refresh = ValueNotifier<int>(0);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final location = state.uri.path;

      // A tela de apresentação é sempre acessível e decide o próximo passo.
      if (location == '/splash') {
        return null;
      }

      final auth = ref.read(authControllerProvider);
      final role = auth.role;

      if (!auth.isAuthenticated) {
        return location == '/login' ? null : '/login';
      }

      if (role == null) {
        return '/login';
      }

      if (location == '/' || location == '/login') {
        return role.homePath;
      }

      final allowedPrefixByRole = <UserRole, List<String>>{
        UserRole.educando: ['/educando'],
        UserRole.educador: ['/educador'],
        UserRole.gestao: ['/gestao', '/educador'],
      };
      final allowedPrefixes = allowedPrefixByRole[role] ?? const <String>[];
      final canAccessRoute = allowedPrefixes.any(location.startsWith);
      if (!canAccessRoute) {
        return role.homePath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      // Educando
      GoRoute(
        path: '/educando/home',
        builder: (context, state) => const EducandoShell(),
      ),
      GoRoute(
        path: '/educando/curso/:id',
        builder: (context, state) =>
            CursoDetailScreen(courseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/educando/forum/:id',
        builder: (context, state) =>
            ForumDetailScreen(forumId: state.pathParameters['id']!),
      ),

      // Educador
      GoRoute(
        path: '/educador/dashboard',
        builder: (context, state) => const EducadorShell(),
      ),
      GoRoute(
        path: '/educador/aluno/:id',
        builder: (context, state) =>
            AlunoDetailScreen(studentId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/educador/turma/:id',
        builder: (context, state) =>
            TurmaDetailScreen(classId: state.pathParameters['id']!),
      ),

      // Gestão
      GoRoute(
        path: '/gestao/overview',
        builder: (context, state) => const GestaoShell(),
      ),
      GoRoute(
        path: '/gestao/professor/:id',
        builder: (context, state) =>
            ProfessorDetailScreen(teacherId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/gestao/turma/:id',
        builder: (context, state) =>
            TurmaDetailScreen(classId: state.pathParameters['id']!),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('EuroONE')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tela não encontrada'),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home_outlined),
              label: const Text('Voltar ao início'),
            ),
          ],
        ),
      ),
    ),
  );
});
