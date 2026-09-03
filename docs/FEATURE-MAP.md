# Feature Map

> Auto-maintained index of every user-facing feature and the code path that implements it. Updated alongside the code - not after the fact.

## Splash / Apresentação

Tela inicial com a marca EuroONE que transiciona automaticamente para o login (ou para a home da persona, se já autenticado).

**Flow:**

1. `lib/main.dart` - `main()` starts Flutter running `EuroOneApp` inside a `ProviderScope`.
2. `lib/app/routes.dart` - `appRouterProvider` sets `/splash` as the initial location.
3. `lib/features/splash/splash_screen.dart` - `SplashScreen` shows the brand and a `Timer` navigates via `context.go`.

---

## Login mock por persona

Login com e-mail e senha validados contra usuários mock. As credenciais das três personas ficam visíveis na própria tela, cada uma com um botão "Entrar".

**Flow:**

1. `lib/features/auth/login_screen.dart` - `LoginScreen` renders the form and the `_CredentialsPanel` with the three visible credentials.
2. `lib/features/auth/auth_controller.dart` - `AuthController.signInWithCredentials` validates and updates `AuthState`.
3. `lib/features/auth/auth_repository.dart` - `MockAuthRepository` resolves the user via `mockUserFromCredentials`.
4. `lib/core/data/mock_data.dart` - `mockCredentials`, `mockLoginUsersByEmail`, and `mockUsers` hold the mock identities.
5. `lib/app/routes.dart` - redirect sends each role to its `homePath` and blocks cross-role routes.

---

## Educando: Perfil

Dados do usuário, progresso da trilha, conquistas/itens adquiridos e missões em andamento.

**Flow:**

1. `lib/features/educando/educando_shell.dart` - `EducandoShell` hosts the bottom navigation (Perfil / Cursos e Fóruns).
2. `lib/features/educando/perfil/educando_perfil_view.dart` - `EducandoPerfilView` renders header, metrics, progress, rewards, and missions from `mock_data.dart`.

---

## Educando: Cursos e Fóruns (+ detalhes)

Lista unificada de cursos e tópicos de fórum; cada item abre uma tela de detalhe recebendo o id como parâmetro de rota.

**Flow:**

1. `lib/features/educando/cursos/educando_cursos_view.dart` - lists `mockCourses` and `mockForums`; taps push `/educando/curso/:id` or `/educando/forum/:id`.
2. `lib/features/educando/cursos/curso_detail_screen.dart` - `CursoDetailScreen` shows disciplines, lessons, and course forums via `courseById`/`disciplinesForCourse`.
3. `lib/features/educando/cursos/forum_detail_screen.dart` - `ForumDetailScreen` shows the topic and its messages via `forumById`/`messagesForForum`.

---

## Educador: Desempenho da turma

Indicadores da turma, gráfico de dispersão Presença × Engajamento (fl_chart), QR de check-in e lista de acompanhamento individual com filtro por nível de cuidado.

**Flow:**

1. `lib/features/educador/educador_shell.dart` - `EducadorShell` hosts the bottom navigation (Desempenho / Turmas).
2. `lib/features/educador/desempenho/educador_desempenho_view.dart` - metrics, scatter chart, QR card, filtered student list; taps push `/educador/aluno/:id`.
3. `lib/features/educador/alunos/aluno_detail_screen.dart` - `AlunoDetailScreen` shows individual indicators and care plan via `suggestedStudentById`.

---

## Educador: Turmas (+ detalhe)

Visualização das turmas com indicadores; cada turma abre um detalhe com gráfico e lista de educandos.

**Flow:**

1. `lib/features/educador/turmas/educador_turmas_view.dart` - lists `mockClasses`; taps push `/educador/turma/:id`.
2. `lib/features/shared_detail/turma_detail_screen.dart` - `TurmaDetailScreen` (shared with Gestão) shows metrics, bar chart, and students; students push `/educador/aluno/:id`.

---

## Gestão: Painel de professores (+ detalhe)

Informações do corpo docente com gráfico de barras de engajamento por professor.

**Flow:**

1. `lib/features/gestao/gestao_shell.dart` - `GestaoShell` hosts the bottom navigation (Professores / Visão geral).
2. `lib/features/gestao/professores/gestao_professores_view.dart` - metrics, `SimpleBarChart` per teacher, teacher list; taps push `/gestao/professor/:id`.
3. `lib/features/gestao/professores/professor_detail_screen.dart` - `ProfessorDetailScreen` shows indicators and disciplines via `teacherById`.

---

## Gestão: Visão geral (+ detalhe de turma)

Métricas do sistema, gráfico de linha da evolução institucional, saúde das turmas com filtros, quedas de engajamento e alertas consolidados.

**Flow:**

1. `lib/features/gestao/visao/gestao_visao_view.dart` - metrics, `_EvolutionLineChart` (fl_chart), filters, class health list; taps push `/gestao/turma/:id`.
2. `lib/features/shared_detail/turma_detail_screen.dart` - shared class detail screen.

---

## Componentes compartilhados

- `lib/shared/widgets/app_shell.dart` - logged-in chrome (AppBar, user info, logout, optional bottom navigation).
- `lib/shared/widgets/detail_scaffold.dart` - chrome for detail screens with automatic back button.
- `lib/shared/widgets/metric_card.dart`, `section_panel.dart`, `status_badge.dart`, `filter_bar.dart` - building blocks reused across personas.
- `lib/shared/widgets/simple_bar_chart.dart` - reusable fl_chart bar chart colored by status.
- `lib/shared/responsive/responsive_grid.dart` - responsive metric grid.