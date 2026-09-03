import 'package:app_euro_one/app/app.dart';
import 'package:app_euro_one/core/data/mock_data.dart';
import 'package:app_euro_one/core/models/app_user.dart';
import 'package:app_euro_one/features/auth/auth_repository.dart';
import 'package:app_euro_one/features/educador/educador_shell.dart';
import 'package:app_euro_one/features/educando/educando_shell.dart';
import 'package:app_euro_one/features/gestao/gestao_shell.dart';
import 'package:app_euro_one/features/gestao/professores/professor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renderiza login com formulario e credenciais visiveis', (
    tester,
  ) async {
    await _bootToLogin(tester);

    expect(find.text('EuroONE'), findsWidgets);
    expect(find.text('Entrar na plataforma'), findsOneWidget);
    expect(find.text('Credenciais de acesso'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('login do educando redireciona para a area do educando', (
    tester,
  ) async {
    await _bootToLogin(tester);
    await _login(tester, 'aluno@euroone.dev', '123456');

    expect(find.byType(EducandoShell), findsOneWidget);
    expect(find.text('Conquistas e itens adquiridos'), findsOneWidget);
  });

  testWidgets('login do educador redireciona para o desempenho da turma', (
    tester,
  ) async {
    await _bootToLogin(tester);
    await _login(tester, 'professor@euroone.dev', '123456');

    expect(find.byType(EducadorShell), findsOneWidget);
    expect(find.text('Presença x Engajamento'), findsOneWidget);
  });

  testWidgets('login da gestao redireciona para o painel de professores', (
    tester,
  ) async {
    await _bootToLogin(tester);
    await _login(tester, 'gestao@euroone.dev', '123456');

    expect(find.byType(GestaoShell), findsOneWidget);
    expect(find.text('Painel de professores'), findsOneWidget);
  });

  testWidgets('credencial invalida mostra mensagem e permanece no login', (
    tester,
  ) async {
    await _bootToLogin(tester);
    await _login(tester, 'aluno@euroone.dev', 'senha-errada');

    expect(
      find.text(
        'Não encontramos esse acesso. Revise os dados e tente novamente.',
      ),
      findsOneWidget,
    );
    expect(find.text('Entrar na plataforma'), findsOneWidget);
    expect(find.byType(EducandoShell), findsNothing);
  });

  testWidgets('gestao abre o detalhe de um professor (passagem de parametro)', (
    tester,
  ) async {
    await _bootToLogin(tester);
    await _login(tester, 'gestao@euroone.dev', '123456');

    final teacherTile = find.text('Prof. Rafael Martins');
    await tester.ensureVisible(teacherTile);
    await tester.tap(teacherTile);
    await tester.pumpAndSettle();

    expect(find.byType(ProfessorDetailScreen), findsOneWidget);
    expect(find.text('Disciplinas'), findsOneWidget);
  });

  test('datasets mock tem volume coerente por categoria principal', () {
    expect(mockUsers.length, greaterThanOrEqualTo(10));
    expect(mockSuggestedStudents.length, greaterThanOrEqualTo(10));
    expect(mockCourses.length, greaterThanOrEqualTo(10));
    expect(mockClasses.length, greaterThanOrEqualTo(10));
    expect(mockDisciplines.length, greaterThanOrEqualTo(10));
    expect(mockLessons.length, greaterThanOrEqualTo(10));
    expect(mockForums.length, greaterThanOrEqualTo(10));
    expect(mockAssignments.length, greaterThanOrEqualTo(10));
    expect(mockAlerts.length, greaterThanOrEqualTo(10));
    expect(mockRewards.length, greaterThanOrEqualTo(10));
    expect(mockMissions.length, greaterThanOrEqualTo(10));
    expect(mockMetrics.length, greaterThanOrEqualTo(10));
    expect(mockTeachers.length, greaterThanOrEqualTo(6));
  });
}

Widget _buildTestApp() {
  return ProviderScope(
    overrides: [
      authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
    ],
    child: const EuroOneApp(),
  );
}

/// Sobe o app e avança a splash até chegar na tela de login.
Future<void> _bootToLogin(WidgetTester tester) async {
  await tester.pumpWidget(_buildTestApp());
  await tester.pump();
  // Dispara o timer da splash e navega para o login.
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();
}

Future<void> _login(WidgetTester tester, String email, String password) async {
  await tester.enterText(find.byType(TextFormField).first, email);
  await tester.enterText(find.byType(TextFormField).last, password);
  final loginButton = find.widgetWithText(FilledButton, 'Entrar');
  await tester.ensureVisible(loginButton);
  await tester.tap(loginButton);
  await tester.pumpAndSettle();
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return mockUserFromCredentials(email, password);
  }

  @override
  Future<void> signOut() async {}
}
