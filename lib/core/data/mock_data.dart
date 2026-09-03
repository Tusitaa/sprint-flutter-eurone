import '../models/app_user.dart';
import '../models/dashboard_models.dart';
import '../models/user_role.dart';

const mockRequiredPassword = '123456';

const mockUsers = [
  AppUser(
    id: 'u-edu-001',
    name: 'Ana Clara Souza',
    role: UserRole.educando,
    email: 'aluno@euroone.dev',
    segment: 'Educando',
    campus: 'EurON Paulista',
    badgeCode: 'ALN-1001',
    learningTrack: 'Farmacologia Clínica',
    className: 'Turma EURON A',
  ),
  AppUser(
    id: 'u-prof-001',
    name: 'Prof. Rafael Martins',
    role: UserRole.educador,
    email: 'professor@euroone.dev',
    segment: 'Educador',
    campus: 'EurON Butantã',
    badgeCode: 'PF-102030',
  ),
  AppUser(
    id: 'u-gest-001',
    name: 'Camila Andrade',
    role: UserRole.gestao,
    email: 'gestao@euroone.dev',
    segment: 'Gestão',
    campus: 'Eurofarma Matriz',
    badgeCode: 'GST-998877',
  ),
  AppUser(
    id: 'u-edu-002',
    name: 'João Victor',
    role: UserRole.educando,
    email: 'joaovictor@mock.com',
    segment: 'Educando',
    campus: 'EurON Paulista',
    badgeCode: 'ALN-1002',
    learningTrack: 'Boas Práticas em Produção',
    className: 'Turma EURON A',
  ),
  AppUser(
    id: 'u-edu-003',
    name: 'Camila Rocha',
    role: UserRole.educando,
    email: 'camilarocha@mock.com',
    segment: 'Educando',
    campus: 'EurON Butantã',
    badgeCode: 'ALN-1003',
    learningTrack: 'Qualidade e Auditoria',
    className: 'Turma EURON B',
  ),
  AppUser(
    id: 'u-edu-004',
    name: 'Bruno Lima',
    role: UserRole.educando,
    email: 'brunolima@mock.com',
    segment: 'Educando',
    campus: 'EurON Sorocaba',
    badgeCode: 'ALN-1004',
    learningTrack: 'Análises Laboratoriais',
    className: 'Turma EURON C',
  ),
  AppUser(
    id: 'u-prof-002',
    name: 'Ana Duarte',
    role: UserRole.educador,
    email: 'anaduarte@mock.com',
    segment: 'Educador',
    campus: 'EurON Sorocaba',
    badgeCode: 'PF-204455',
  ),
  AppUser(
    id: 'u-prof-003',
    name: 'Thiago Mendes',
    role: UserRole.educador,
    email: 'thiagomendes@mock.com',
    segment: 'Educador',
    campus: 'EurON Ribeirão',
    badgeCode: 'PF-908010',
  ),
  AppUser(
    id: 'u-gest-002',
    name: 'Patricia Azevedo',
    role: UserRole.gestao,
    email: 'patricia@mock.com',
    segment: 'Gestão',
    campus: 'Eurofarma Matriz',
    badgeCode: 'GST-445566',
  ),
  AppUser(
    id: 'u-gest-003',
    name: 'Marcelo Paes',
    role: UserRole.gestao,
    email: 'marcelo@mock.com',
    segment: 'Gestão',
    campus: 'Eurofarma Matriz',
    badgeCode: 'GST-778899',
  ),
];

/// Credenciais de acesso do MVP. Todas usam a senha [mockRequiredPassword]
/// e são exibidas diretamente na tela de login para facilitar a avaliação.
const mockLoginUsersByEmail = {
  'aluno@euroone.dev': 'u-edu-001',
  'professor@euroone.dev': 'u-prof-001',
  'gestao@euroone.dev': 'u-gest-001',
};

/// Lista apresentada na tela de login (persona, e-mail e senha visíveis).
class MockCredential {
  const MockCredential({
    required this.role,
    required this.email,
    required this.password,
  });

  final UserRole role;
  final String email;
  final String password;
}

const mockCredentials = [
  MockCredential(
    role: UserRole.educando,
    email: 'aluno@euroone.dev',
    password: mockRequiredPassword,
  ),
  MockCredential(
    role: UserRole.educador,
    email: 'professor@euroone.dev',
    password: mockRequiredPassword,
  ),
  MockCredential(
    role: UserRole.gestao,
    email: 'gestao@euroone.dev',
    password: mockRequiredPassword,
  ),
];

final Map<String, AppUser> _mockUsersById = {
  for (final user in mockUsers) user.id: user,
};

AppUser? mockUserFromCredentials(String email, String password) {
  final normalizedEmail = email.trim().toLowerCase();
  final normalizedPassword = password.trim();
  if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
    return null;
  }
  if (normalizedPassword != mockRequiredPassword) {
    return null;
  }
  final userId = mockLoginUsersByEmail[normalizedEmail];
  if (userId == null) {
    return null;
  }
  return _mockUsersById[userId];
}

AppUser mockDefaultUserForRole(UserRole role) {
  return mockUsers.firstWhere((item) => item.role == role);
}

const mockSuggestedStudents = [
  SuggestedStudent(
    id: 'sug-01',
    name: 'Ana Clara Souza',
    className: 'Turma EURON A',
    attendance: 92,
    engagement: 88,
    riskLevel: 'baixo',
    primaryNeed: 'Manter ritmo de entregas',
    lastInteractionDays: 1,
  ),
  SuggestedStudent(
    id: 'sug-02',
    name: 'João Pedro Lima',
    className: 'Turma EURON A',
    attendance: 84,
    engagement: 48,
    riskLevel: 'atencao',
    primaryNeed: 'Apoio no forum semanal',
    lastInteractionDays: 7,
  ),
  SuggestedStudent(
    id: 'sug-03',
    name: 'Mariana Costa',
    className: 'Turma EURON B',
    attendance: 58,
    engagement: 72,
    riskLevel: 'atencao',
    primaryNeed: 'Plano de faltas',
    lastInteractionDays: 5,
  ),
  SuggestedStudent(
    id: 'sug-04',
    name: 'Lucas Ferreira',
    className: 'Turma EURON B',
    attendance: 52,
    engagement: 39,
    riskLevel: 'critico',
    primaryNeed: 'Contato ativo com mentor',
    lastInteractionDays: 10,
  ),
  SuggestedStudent(
    id: 'sug-05',
    name: 'Beatriz Almeida',
    className: 'Turma EURON C',
    attendance: 76,
    engagement: 81,
    riskLevel: 'baixo',
    primaryNeed: 'Desafio avancado de projeto',
    lastInteractionDays: 2,
  ),
  SuggestedStudent(
    id: 'sug-06',
    name: 'Gabriel Santos',
    className: 'Turma EURON C',
    attendance: 68,
    engagement: 55,
    riskLevel: 'atencao',
    primaryNeed: 'Reforco em atividades práticas',
    lastInteractionDays: 6,
  ),
  SuggestedStudent(
    id: 'sug-07',
    name: 'Isabela Rocha',
    className: 'Turma EURON D',
    attendance: 89,
    engagement: 74,
    riskLevel: 'baixo',
    primaryNeed: 'Mentoria para lideranca de grupo',
    lastInteractionDays: 3,
  ),
  SuggestedStudent(
    id: 'sug-08',
    name: 'Pedro Henrique',
    className: 'Turma EURON E',
    attendance: 61,
    engagement: 58,
    riskLevel: 'atencao',
    primaryNeed: 'Acompanhamento de frequência',
    lastInteractionDays: 8,
  ),
  SuggestedStudent(
    id: 'sug-09',
    name: 'Larissa Nunes',
    className: 'Turma EURON F',
    attendance: 95,
    engagement: 90,
    riskLevel: 'baixo',
    primaryNeed: 'Trilha de excelencia',
    lastInteractionDays: 1,
  ),
  SuggestedStudent(
    id: 'sug-10',
    name: 'Rafael Gomes',
    className: 'Turma EURON F',
    attendance: 49,
    engagement: 44,
    riskLevel: 'critico',
    primaryNeed: 'Plano de recuperação imediato',
    lastInteractionDays: 12,
  ),
];

const mockCourses = [
  CourseInfo(
    id: 'course-01',
    name: 'Farmacologia Clínica',
    track: 'Saúde',
    phase: 'M1',
  ),
  CourseInfo(
    id: 'course-02',
    name: 'Produção Estéril',
    track: 'Operações',
    phase: 'M1',
  ),
  CourseInfo(
    id: 'course-03',
    name: 'Qualidade e Compliance',
    track: 'Qualidade',
    phase: 'M1',
  ),
  CourseInfo(
    id: 'course-04',
    name: 'Análises Instrumentais',
    track: 'Laboratório',
    phase: 'M2',
  ),
  CourseInfo(
    id: 'course-05',
    name: 'Boas Práticas Regulatórias',
    track: 'Regulatório',
    phase: 'M2',
  ),
  CourseInfo(
    id: 'course-06',
    name: 'Gestão de Processos',
    track: 'Gestão',
    phase: 'M2',
  ),
  CourseInfo(
    id: 'course-07',
    name: 'Segurança do Paciente',
    track: 'Saúde',
    phase: 'M3',
  ),
  CourseInfo(
    id: 'course-08',
    name: 'Tecnologias Digitais em Saúde',
    track: 'Digital',
    phase: 'M3',
  ),
  CourseInfo(
    id: 'course-09',
    name: 'Pesquisa Aplicada',
    track: 'Inovação',
    phase: 'M3',
  ),
  CourseInfo(
    id: 'course-10',
    name: 'Projeto Integrador',
    track: 'Capstone',
    phase: 'M4',
  ),
];

const mockClasses = [
  ClassSummary(
    id: 'class-01',
    name: 'Turma EURON A',
    students: 32,
    attendanceAverage: 82,
    engagementAverage: 76,
    alerts: 4,
    riskLabel: 'atencao',
    evolutionLabel: '+4.2%',
  ),
  ClassSummary(
    id: 'class-02',
    name: 'Turma EURON B',
    students: 28,
    attendanceAverage: 74,
    engagementAverage: 69,
    alerts: 7,
    riskLabel: 'critico',
    evolutionLabel: '-2.5%',
  ),
  ClassSummary(
    id: 'class-03',
    name: 'Turma EURON C',
    students: 30,
    attendanceAverage: 88,
    engagementAverage: 83,
    alerts: 2,
    riskLabel: 'baixo',
    evolutionLabel: '+6.8%',
  ),
  ClassSummary(
    id: 'class-04',
    name: 'Turma EURON D',
    students: 26,
    attendanceAverage: 85,
    engagementAverage: 79,
    alerts: 3,
    riskLabel: 'baixo',
    evolutionLabel: '+3.1%',
  ),
  ClassSummary(
    id: 'class-05',
    name: 'Turma EURON E',
    students: 25,
    attendanceAverage: 71,
    engagementAverage: 63,
    alerts: 6,
    riskLabel: 'atencao',
    evolutionLabel: '-1.2%',
  ),
  ClassSummary(
    id: 'class-06',
    name: 'Turma EURON F',
    students: 29,
    attendanceAverage: 69,
    engagementAverage: 60,
    alerts: 8,
    riskLabel: 'critico',
    evolutionLabel: '-3.4%',
  ),
  ClassSummary(
    id: 'class-07',
    name: 'Turma EURON G',
    students: 31,
    attendanceAverage: 90,
    engagementAverage: 86,
    alerts: 1,
    riskLabel: 'baixo',
    evolutionLabel: '+7.3%',
  ),
  ClassSummary(
    id: 'class-08',
    name: 'Turma EURON H',
    students: 27,
    attendanceAverage: 77,
    engagementAverage: 72,
    alerts: 4,
    riskLabel: 'atencao',
    evolutionLabel: '+1.4%',
  ),
  ClassSummary(
    id: 'class-09',
    name: 'Turma EURON I',
    students: 34,
    attendanceAverage: 83,
    engagementAverage: 75,
    alerts: 5,
    riskLabel: 'atencao',
    evolutionLabel: '+0.8%',
  ),
  ClassSummary(
    id: 'class-10',
    name: 'Turma EURON J',
    students: 24,
    attendanceAverage: 93,
    engagementAverage: 89,
    alerts: 0,
    riskLabel: 'baixo',
    evolutionLabel: '+8.1%',
  ),
];

const mockDisciplines = [
  DisciplineInfo(
    id: 'disc-01',
    courseId: 'course-01',
    name: 'Bases Clínicas',
    teacherName: 'Paulo Freitas',
  ),
  DisciplineInfo(
    id: 'disc-02',
    courseId: 'course-02',
    name: 'Processos Assépticos',
    teacherName: 'Ana Duarte',
  ),
  DisciplineInfo(
    id: 'disc-03',
    courseId: 'course-03',
    name: 'Auditoria de Qualidade',
    teacherName: 'Thiago Mendes',
  ),
  DisciplineInfo(
    id: 'disc-04',
    courseId: 'course-04',
    name: 'Cromatografia',
    teacherName: 'Paulo Freitas',
  ),
  DisciplineInfo(
    id: 'disc-05',
    courseId: 'course-05',
    name: 'Regulatório Global',
    teacherName: 'Ana Duarte',
  ),
  DisciplineInfo(
    id: 'disc-06',
    courseId: 'course-06',
    name: 'Gestão Lean',
    teacherName: 'Thiago Mendes',
  ),
  DisciplineInfo(
    id: 'disc-07',
    courseId: 'course-07',
    name: 'Protocolos Assistenciais',
    teacherName: 'Paulo Freitas',
  ),
  DisciplineInfo(
    id: 'disc-08',
    courseId: 'course-08',
    name: 'Dados em Saúde',
    teacherName: 'Ana Duarte',
  ),
  DisciplineInfo(
    id: 'disc-09',
    courseId: 'course-09',
    name: 'Métodos Científicos',
    teacherName: 'Thiago Mendes',
  ),
  DisciplineInfo(
    id: 'disc-10',
    courseId: 'course-10',
    name: 'Projeto Integrador',
    teacherName: 'Paulo Freitas',
  ),
];

const mockLessons = [
  LessonInfo(
    id: 'lesson-01',
    disciplineId: 'disc-01',
    title: 'Receptores e mecanismos',
    dateLabel: 'Seg 08:00',
    format: 'Hibrida',
    durationMinutes: 90,
  ),
  LessonInfo(
    id: 'lesson-02',
    disciplineId: 'disc-02',
    title: 'Fluxo estéril em sala limpa',
    dateLabel: 'Seg 10:00',
    format: 'Presencial',
    durationMinutes: 120,
  ),
  LessonInfo(
    id: 'lesson-03',
    disciplineId: 'disc-03',
    title: 'Checklist de auditoria',
    dateLabel: 'Ter 09:00',
    format: 'Online',
    durationMinutes: 80,
  ),
  LessonInfo(
    id: 'lesson-04',
    disciplineId: 'disc-04',
    title: 'Introducao ao HPLC',
    dateLabel: 'Ter 14:00',
    format: 'Presencial',
    durationMinutes: 110,
  ),
  LessonInfo(
    id: 'lesson-05',
    disciplineId: 'disc-05',
    title: 'Normas ICH essenciais',
    dateLabel: 'Qua 08:00',
    format: 'Hibrida',
    durationMinutes: 90,
  ),
  LessonInfo(
    id: 'lesson-06',
    disciplineId: 'disc-06',
    title: 'Mapeamento de fluxo de valor',
    dateLabel: 'Qua 13:00',
    format: 'Online',
    durationMinutes: 75,
  ),
  LessonInfo(
    id: 'lesson-07',
    disciplineId: 'disc-07',
    title: 'Eventos adversos e resposta',
    dateLabel: 'Qui 09:30',
    format: 'Presencial',
    durationMinutes: 95,
  ),
  LessonInfo(
    id: 'lesson-08',
    disciplineId: 'disc-08',
    title: 'Indicadores de aprendizado',
    dateLabel: 'Qui 15:00',
    format: 'Hibrida',
    durationMinutes: 85,
  ),
  LessonInfo(
    id: 'lesson-09',
    disciplineId: 'disc-09',
    title: 'Hipótese e desenho experimental',
    dateLabel: 'Sex 10:00',
    format: 'Online',
    durationMinutes: 90,
  ),
  LessonInfo(
    id: 'lesson-10',
    disciplineId: 'disc-10',
    title: 'Pitch final de projeto',
    dateLabel: 'Sex 16:00',
    format: 'Presencial',
    durationMinutes: 120,
  ),
];

const mockForums = [
  ForumInfo(
    id: 'forum-01',
    disciplineId: 'disc-01',
    title: 'Resumo da aula de hoje',
    authorName: 'Larissa Nogueira',
    replies: 14,
    lastActivityLabel: 'ha 1h',
  ),
  ForumInfo(
    id: 'forum-02',
    disciplineId: 'disc-02',
    title: 'Dúvidas de validação asséptica',
    authorName: 'João Victor',
    replies: 8,
    lastActivityLabel: 'ha 2h',
  ),
  ForumInfo(
    id: 'forum-03',
    disciplineId: 'disc-03',
    title: 'Checklist compartilhado',
    authorName: 'Camila Rocha',
    replies: 10,
    lastActivityLabel: 'ha 3h',
  ),
  ForumInfo(
    id: 'forum-04',
    disciplineId: 'disc-04',
    title: 'Leitura de cromatogramas',
    authorName: 'Bruno Lima',
    replies: 5,
    lastActivityLabel: 'ha 4h',
  ),
  ForumInfo(
    id: 'forum-05',
    disciplineId: 'disc-05',
    title: 'Interpretacao da norma',
    authorName: 'Fernanda Reis',
    replies: 12,
    lastActivityLabel: 'ha 5h',
  ),
  ForumInfo(
    id: 'forum-06',
    disciplineId: 'disc-06',
    title: 'Exemplo de plano lean',
    authorName: 'Gabriel Monteiro',
    replies: 7,
    lastActivityLabel: 'ha 6h',
  ),
  ForumInfo(
    id: 'forum-07',
    disciplineId: 'disc-07',
    title: 'Caso clínico colaborativo',
    authorName: 'Helena Prado',
    replies: 9,
    lastActivityLabel: 'ha 7h',
  ),
  ForumInfo(
    id: 'forum-08',
    disciplineId: 'disc-08',
    title: 'Dashboard de indicadores',
    authorName: 'Igor Matos',
    replies: 6,
    lastActivityLabel: 'ha 8h',
  ),
  ForumInfo(
    id: 'forum-09',
    disciplineId: 'disc-09',
    title: 'Discussao de hipótese',
    authorName: 'Juliana Mota',
    replies: 11,
    lastActivityLabel: 'ha 9h',
  ),
  ForumInfo(
    id: 'forum-10',
    disciplineId: 'disc-10',
    title: 'Preparacao para o pitch',
    authorName: 'Kaique Silva',
    replies: 4,
    lastActivityLabel: 'ha 10h',
  ),
];

const mockAssignments = [
  AssignmentInfo(
    id: 'assg-01',
    disciplineId: 'disc-01',
    title: 'Mapa de receptores',
    dueLabel: 'Hoje',
    status: 'pendente',
    scoreLabel: '--',
  ),
  AssignmentInfo(
    id: 'assg-02',
    disciplineId: 'disc-02',
    title: 'Relatório de sala limpa',
    dueLabel: 'Amanha',
    status: 'pendente',
    scoreLabel: '--',
  ),
  AssignmentInfo(
    id: 'assg-03',
    disciplineId: 'disc-03',
    title: 'Checklist auditavel',
    dueLabel: 'Qua',
    status: 'entregue',
    scoreLabel: '9,2',
  ),
  AssignmentInfo(
    id: 'assg-04',
    disciplineId: 'disc-04',
    title: 'Leitura HPLC guiada',
    dueLabel: 'Qua',
    status: 'atrasada',
    scoreLabel: '--',
  ),
  AssignmentInfo(
    id: 'assg-05',
    disciplineId: 'disc-05',
    title: 'Resumo ICH',
    dueLabel: 'Qui',
    status: 'entregue',
    scoreLabel: '8,6',
  ),
  AssignmentInfo(
    id: 'assg-06',
    disciplineId: 'disc-06',
    title: 'Plano de melhoria',
    dueLabel: 'Qui',
    status: 'pendente',
    scoreLabel: '--',
  ),
  AssignmentInfo(
    id: 'assg-07',
    disciplineId: 'disc-07',
    title: 'Analise de evento adverso',
    dueLabel: 'Sex',
    status: 'entregue',
    scoreLabel: '9,0',
  ),
  AssignmentInfo(
    id: 'assg-08',
    disciplineId: 'disc-08',
    title: 'Painel de indicadores',
    dueLabel: 'Sex',
    status: 'pendente',
    scoreLabel: '--',
  ),
  AssignmentInfo(
    id: 'assg-09',
    disciplineId: 'disc-09',
    title: 'Hipótese validavel',
    dueLabel: 'Sab',
    status: 'entregue',
    scoreLabel: '8,9',
  ),
  AssignmentInfo(
    id: 'assg-10',
    disciplineId: 'disc-10',
    title: 'Pitch do projeto',
    dueLabel: 'Sab',
    status: 'pendente',
    scoreLabel: '--',
  ),
];

const mockAttendance = [
  AttendanceRecord(
    id: 'att-01',
    studentId: 'sug-01',
    classId: 'class-01',
    dateLabel: '2026-04-21',
    present: true,
  ),
  AttendanceRecord(
    id: 'att-02',
    studentId: 'sug-02',
    classId: 'class-01',
    dateLabel: '2026-04-22',
    present: true,
  ),
  AttendanceRecord(
    id: 'att-03',
    studentId: 'sug-03',
    classId: 'class-02',
    dateLabel: '2026-04-23',
    present: false,
  ),
  AttendanceRecord(
    id: 'att-04',
    studentId: 'sug-04',
    classId: 'class-02',
    dateLabel: '2026-04-24',
    present: false,
  ),
  AttendanceRecord(
    id: 'att-05',
    studentId: 'sug-05',
    classId: 'class-03',
    dateLabel: '2026-04-25',
    present: true,
  ),
  AttendanceRecord(
    id: 'att-06',
    studentId: 'sug-06',
    classId: 'class-03',
    dateLabel: '2026-04-26',
    present: true,
  ),
  AttendanceRecord(
    id: 'att-07',
    studentId: 'sug-07',
    classId: 'class-04',
    dateLabel: '2026-04-27',
    present: true,
  ),
  AttendanceRecord(
    id: 'att-08',
    studentId: 'sug-08',
    classId: 'class-05',
    dateLabel: '2026-04-28',
    present: false,
  ),
  AttendanceRecord(
    id: 'att-09',
    studentId: 'sug-09',
    classId: 'class-06',
    dateLabel: '2026-04-29',
    present: true,
  ),
  AttendanceRecord(
    id: 'att-10',
    studentId: 'sug-10',
    classId: 'class-06',
    dateLabel: '2026-04-30',
    present: false,
  ),
];

const mockAlerts = [
  AlertItem(
    id: 'alert-01',
    studentName: 'João Pedro Lima',
    level: 'critico',
    title: 'Presença e engajamento em queda',
    reason: 'Presença abaixo de 60% e baixa atividade no Moodle.',
    recommendedAction: 'Contato em ate 24h e plano de recuperação de faltas.',
  ),
  AlertItem(
    id: 'alert-02',
    studentName: 'Mariana Costa',
    level: 'atencao',
    title: 'Participação online reduzida',
    reason: 'Participação em foruns caiu nos últimos 14 dias.',
    recommendedAction: 'Ativar missão curta e reforcar rotina de estudos.',
  ),
  AlertItem(
    id: 'alert-03',
    studentName: 'Pedro Henrique',
    level: 'atencao',
    title: 'Oscilacao de presença',
    reason: 'Faltou em duas aulas consecutivas.',
    recommendedAction: 'Agendar conversa individual com educador.',
  ),
  AlertItem(
    id: 'alert-04',
    studentName: 'Isabela Rocha',
    level: 'atencao',
    title: 'Entrega atrasada',
    reason: 'Atividade prática sem envio ha 3 dias.',
    recommendedAction: 'Definir novo prazo com acompanhamento diario.',
  ),
  AlertItem(
    id: 'alert-05',
    studentName: 'Rafael Gomes',
    level: 'atencao',
    title: 'Engajamento de fronteira',
    reason: 'Engajamento abaixo de 60% por duas semanas.',
    recommendedAction: 'Sugerir dupla de estudo e missão colaborativa.',
  ),
  AlertItem(
    id: 'alert-06',
    studentName: 'João Pedro Lima',
    level: 'critico',
    title: 'Risco de evasão',
    reason: 'Frequência e entregas muito abaixo da turma.',
    recommendedAction: 'Acionar suporte socioeducacional e gestor da turma.',
  ),
  AlertItem(
    id: 'alert-07',
    studentName: 'Ana Clara Souza',
    level: 'baixo',
    title: 'Sem risco imediato',
    reason: 'Boa frequência e evolução constante.',
    recommendedAction: 'Manter trilha de excelencia e mentoria de pares.',
  ),
  AlertItem(
    id: 'alert-08',
    studentName: 'Beatriz Almeida',
    level: 'baixo',
    title: 'Evolução positiva',
    reason: 'Subiu 8 pontos em engajamento no último ciclo.',
    recommendedAction: 'Convidar para protagonizar estudo de caso.',
  ),
  AlertItem(
    id: 'alert-09',
    studentName: 'Larissa Nunes',
    level: 'baixo',
    title: 'Alta consistencia',
    reason: 'Participação constante em aulas e foruns.',
    recommendedAction: 'Estimular papel de mentoria entre colegas.',
  ),
  AlertItem(
    id: 'alert-10',
    studentName: 'Gabriel Santos',
    level: 'atencao',
    title: 'Queda pontual de desempenho',
    reason: 'Nota da última atividade abaixo da média pessoal.',
    recommendedAction: 'Revisão guiada dos pontos de dúvida.',
  ),
];

const mockRewards = [
  RewardItem(
    id: 'reward-01',
    title: 'Mentoria rápida com especialista',
    description: '30 minutos de mentoria com foco em trilha tecnica.',
    costPoints: 400,
    unlocked: true,
  ),
  RewardItem(
    id: 'reward-02',
    title: 'Acesso antecipado ao laboratorio',
    description: 'Janela extra para prática assistida.',
    costPoints: 500,
    unlocked: true,
  ),
  RewardItem(
    id: 'reward-03',
    title: 'Badge Ouro de Assiduidade',
    description: 'Reconhecimento por alta frequência mensal.',
    costPoints: 350,
    unlocked: true,
  ),
  RewardItem(
    id: 'reward-04',
    title: 'Workshop com time de inovacao',
    description: 'Sessao exclusiva com casos reais de saude digital.',
    costPoints: 700,
    unlocked: false,
  ),
  RewardItem(
    id: 'reward-05',
    title: 'Voucher de livro tecnico',
    description: 'Credito para compra de material de estudo.',
    costPoints: 600,
    unlocked: false,
  ),
  RewardItem(
    id: 'reward-06',
    title: 'Dia de shadowing em projeto',
    description: 'Acompanhamento de equipe multidisciplinar.',
    costPoints: 750,
    unlocked: false,
  ),
  RewardItem(
    id: 'reward-07',
    title: 'Ingresso em trilha avancada',
    description: 'Desbloqueio de modulo complementar premium.',
    costPoints: 800,
    unlocked: false,
  ),
  RewardItem(
    id: 'reward-08',
    title: 'Kit de estudos EurON',
    description: 'Material de apoio para ciclos de revisão.',
    costPoints: 300,
    unlocked: true,
  ),
  RewardItem(
    id: 'reward-09',
    title: 'Certificado destaque mensal',
    description: 'Reconhecimento institucional da evolução.',
    costPoints: 450,
    unlocked: true,
  ),
  RewardItem(
    id: 'reward-10',
    title: 'Trilha internacional guiada',
    description: 'Conteudos globais com tutoria em portugues.',
    costPoints: 1000,
    unlocked: false,
  ),
];

const mockMissions = [
  Mission(
    id: 'mission-01',
    title: 'Confirmar presença na aula de hoje',
    description: 'Use o QR Code exibido pelo educador.',
    points: 80,
    completed: false,
    dueLabel: 'Hoje',
  ),
  Mission(
    id: 'mission-02',
    title: 'Concluir atividade no Moodle',
    description: 'Finalize o modulo de boas práticas laboratoriais.',
    points: 120,
    completed: false,
    dueLabel: 'Hoje',
  ),
  Mission(
    id: 'mission-03',
    title: 'Participar do quiz semanal',
    description: 'Responda o quiz de farmacologia ate sexta-feira.',
    points: 60,
    completed: true,
    dueLabel: 'Concluída',
  ),
  Mission(
    id: 'mission-04',
    title: 'Postar no forum da disciplina',
    description: 'Compartilhe uma dúvida tecnica com o grupo.',
    points: 55,
    completed: true,
    dueLabel: 'Concluída',
  ),
  Mission(
    id: 'mission-05',
    title: 'Revisar checklist de qualidade',
    description: 'Validar os pontos criticos da última aula prática.',
    points: 70,
    completed: false,
    dueLabel: 'Amanha',
  ),
  Mission(
    id: 'mission-06',
    title: 'Submeter mini-relatório',
    description: 'Enviar observacoes do experimento guiado.',
    points: 95,
    completed: false,
    dueLabel: 'Qua',
  ),
  Mission(
    id: 'mission-07',
    title: 'Revisão em dupla',
    description: 'Troque feedback com um colega sobre a atividade.',
    points: 50,
    completed: true,
    dueLabel: 'Concluída',
  ),
  Mission(
    id: 'mission-08',
    title: 'Aula ao vivo de reforco',
    description: 'Participar da sessao de dúvidas com o educador.',
    points: 85,
    completed: false,
    dueLabel: 'Qui',
  ),
  Mission(
    id: 'mission-09',
    title: 'Checklist de seguranca',
    description: 'Registrar conformidade no ambiente de prática.',
    points: 65,
    completed: true,
    dueLabel: 'Concluída',
  ),
  Mission(
    id: 'mission-10',
    title: 'Preparar pitch de projeto',
    description: 'Estruturar apresentacao de 3 minutos.',
    points: 110,
    completed: false,
    dueLabel: 'Sex',
  ),
];

const mockEvolution = [
  EvolutionPoint(id: 'evo-01', label: 'S1', value: 61),
  EvolutionPoint(id: 'evo-02', label: 'S2', value: 64),
  EvolutionPoint(id: 'evo-03', label: 'S3', value: 66),
  EvolutionPoint(id: 'evo-04', label: 'S4', value: 68),
  EvolutionPoint(id: 'evo-05', label: 'S5', value: 70),
  EvolutionPoint(id: 'evo-06', label: 'S6', value: 73),
  EvolutionPoint(id: 'evo-07', label: 'S7', value: 75),
  EvolutionPoint(id: 'evo-08', label: 'S8', value: 78),
  EvolutionPoint(id: 'evo-09', label: 'S9', value: 81),
  EvolutionPoint(id: 'evo-10', label: 'S10', value: 84),
];

const mockMetrics = [
  DashboardMetric(
    id: 'metric-01',
    label: 'Frequência média',
    value: '82%',
    helper: 'Últimos 30 dias',
    status: 'info',
    trend: '+2.1%',
  ),
  DashboardMetric(
    id: 'metric-02',
    label: 'Engajamento médio',
    value: '76%',
    helper: 'Moodle + Missões',
    status: 'success',
    trend: '+3.4%',
  ),
  DashboardMetric(
    id: 'metric-03',
    label: 'Alertas criticos',
    value: '6',
    helper: 'Atencao imediata',
    status: 'critical',
    trend: '-1',
  ),
  DashboardMetric(
    id: 'metric-04',
    label: 'Entregas no prazo',
    value: '88%',
    helper: 'Ciclo atual',
    status: 'success',
    trend: '+4.8%',
  ),
  DashboardMetric(
    id: 'metric-05',
    label: 'Participação em forum',
    value: '71%',
    helper: 'Média por turma',
    status: 'attention',
    trend: '+0.9%',
  ),
  DashboardMetric(
    id: 'metric-06',
    label: 'Satisfação de trilha',
    value: '4,6/5',
    helper: 'Pesquisa interna',
    status: 'neutral',
    trend: '+0,2',
  ),
  DashboardMetric(
    id: 'metric-07',
    label: 'Risco de evasão',
    value: '9%',
    helper: 'Indicador consolidado',
    status: 'attention',
    trend: '-0.8%',
  ),
  DashboardMetric(
    id: 'metric-08',
    label: 'Projetos concluídos',
    value: '54',
    helper: 'Semestre atual',
    status: 'info',
    trend: '+6',
  ),
  DashboardMetric(
    id: 'metric-09',
    label: 'Aulas com check-in QR',
    value: '94%',
    helper: 'Uso da solucao',
    status: 'success',
    trend: '+1.5%',
  ),
  DashboardMetric(
    id: 'metric-10',
    label: 'Turmas com evolução',
    value: '8/10',
    helper: 'Comparativo mensal',
    status: 'success',
    trend: '+1',
  ),
];


const mockEducandoSnapshot = EducandoSnapshot(
  studentName: 'Ana Clara Souza',
  progress: 78,
  faltas: 2,
  entregasPendentes: 3,
  points: 1280,
  level: 6,
  streakDays: 6,
);

final List<DashboardMetric> mockEducandoMetrics = [
  mockMetrics[3],
  const DashboardMetric(
    id: 'metric-edu-01',
    label: 'Progresso da trilha',
    value: '78%',
    helper: 'Meta de 85% no ciclo',
    status: 'info',
    trend: '+6%',
  ),
  const DashboardMetric(
    id: 'metric-edu-02',
    label: 'Faltas no mes',
    value: '2',
    helper: 'Dentro do limite recomendado',
    status: 'attention',
    trend: '-1',
  ),
  const DashboardMetric(
    id: 'metric-edu-03',
    label: 'Pontos acumulados',
    value: '1.280',
    helper: 'Nivel 6 desbloqueado',
    status: 'success',
    trend: '+180',
  ),
];

final List<DashboardMetric> mockEducadorMetrics = [
  const DashboardMetric(
    id: 'metric-prof-01',
    label: 'Educandos',
    value: '32',
    helper: 'Turma EURON A ativa',
    status: 'neutral',
  ),
  mockMetrics[0],
  mockMetrics[1],
  const DashboardMetric(
    id: 'metric-prof-02',
    label: 'Alertas de cuidado',
    value: '4',
    helper: '2 criticos e 2 atencao',
    status: 'critical',
    trend: '-1',
  ),
];

final List<DashboardMetric> mockGestaoMetrics = [
  const DashboardMetric(
    id: 'metric-gest-01',
    label: 'Turmas monitoradas',
    value: '10',
    helper: 'Rede EurON corporativa',
    status: 'neutral',
  ),
  const DashboardMetric(
    id: 'metric-gest-02',
    label: 'Educandos ativos',
    value: '286',
    helper: 'Total consolidado',
    status: 'info',
    trend: '+12',
  ),
  mockMetrics[0],
  mockMetrics[2],
];

const mockCarePriorities = [
  CarePriority(
    studentName: 'João Pedro Lima',
    level: 'critico',
    reason: 'Risco de evasão por baixa frequência e baixa entrega.',
    nextAction: 'Contato 1:1 hoje e plano de recuperação com família.',
  ),
  CarePriority(
    studentName: 'Rafael Gomes',
    level: 'critico',
    reason: 'Queda acentuada em presença e engajamento.',
    nextAction: 'Acionar rede de apoio e tutor de referencia.',
  ),
  CarePriority(
    studentName: 'Mariana Costa',
    level: 'atencao',
    reason: 'Participação em forum em queda progressiva.',
    nextAction: 'Definir meta semanal com check-ins curtos.',
  ),
  CarePriority(
    studentName: 'Pedro Henrique',
    level: 'atencao',
    reason: 'Duas faltas recentes em aulas síncronas.',
    nextAction: 'Ajustar plano de presença e material de reposição.',
  ),
  CarePriority(
    studentName: 'Gabriel Santos',
    level: 'atencao',
    reason: 'Entrega pendente e nota oscilante.',
    nextAction: 'Revisão guiada da atividade com prazo combinado.',
  ),
];

const mockActionSuggestions = [
  ActionSuggestion(
    title: 'Missão rápida de retomada',
    description:
        'Criar missão de 15 minutos para reengajar estudantes em atencao.',
    expectedImpact: 'Aumentar participação em ate 8% no ciclo.',
  ),
  ActionSuggestion(
    title: 'Dupla de estudo por afinidade',
    description: 'Parear estudantes referencia com colegas em risco moderado.',
    expectedImpact: 'Melhorar consistencia de entregas semanais.',
  ),
  ActionSuggestion(
    title: 'Feedback de 48 horas',
    description:
        'Responder atividades atrasadas com orientacao objetiva e acolhedora.',
    expectedImpact: 'Reduzir reincidência de atraso em ate 20%.',
  ),
  ActionSuggestion(
    title: 'Plantao de dúvidas tematico',
    description:
        'Abrir encontro curto focado no tópico com maior erro da turma.',
    expectedImpact: 'Elevar nota média da próxima avaliação.',
  ),
];

const mockGestaoEngagementDrops = [
  EngagementDrop(
    className: 'Turma EURON F',
    deltaLabel: '-6,2%',
    reason: 'Baixa adesão ao forum e faltas recorrentes.',
  ),
  EngagementDrop(
    className: 'Turma EURON B',
    deltaLabel: '-4,8%',
    reason: 'Oscilacao de presença em aulas práticas.',
  ),
  EngagementDrop(
    className: 'Turma EURON E',
    deltaLabel: '-3,1%',
    reason: 'Atrasos em entregas de projeto aplicado.',
  ),
];

const mockGestaoTopEvolution = [
  ('Turma EURON J', '+8,1%'),
  ('Turma EURON G', '+7,3%'),
  ('Turma EURON C', '+6,8%'),
];

// Derivado de todas as turmas para que o filtro cubra a mesma lista exibida.
final mockFilterClasses = <FilterOption>[
  const FilterOption(id: 'all', label: 'Todas as turmas'),
  for (final classSummary in mockClasses)
    FilterOption(id: classSummary.id, label: classSummary.name),
];

const mockFilterRiskLevels = [
  FilterOption(id: 'all', label: 'Todos os níveis'),
  FilterOption(id: 'critical', label: 'Crítico'),
  FilterOption(id: 'attention', label: 'Atenção'),
  FilterOption(id: 'low', label: 'Baixo'),
];

// ---------------------------------------------------------------------------
// Professores (painel da Gestão)
// ---------------------------------------------------------------------------

const mockTeachers = [
  TeacherInfo(
    id: 'teacher-01',
    name: 'Prof. Rafael Martins',
    area: 'Farmacologia Clínica',
    campus: 'EurON Butantã',
    classesCount: 3,
    studentsCount: 86,
    attendanceAverage: 88,
    engagementAverage: 84,
    satisfaction: 4.7,
    status: 'success',
    statusLabel: 'Destaque',
    disciplines: ['Bases Clínicas', 'Protocolos Assistenciais'],
  ),
  TeacherInfo(
    id: 'teacher-02',
    name: 'Ana Duarte',
    area: 'Produção Estéril',
    campus: 'EurON Sorocaba',
    classesCount: 2,
    studentsCount: 58,
    attendanceAverage: 81,
    engagementAverage: 77,
    satisfaction: 4.4,
    status: 'info',
    statusLabel: 'Estável',
    disciplines: ['Processos Assépticos', 'Regulatório Global'],
  ),
  TeacherInfo(
    id: 'teacher-03',
    name: 'Thiago Mendes',
    area: 'Qualidade e Compliance',
    campus: 'EurON Ribeirão',
    classesCount: 2,
    studentsCount: 54,
    attendanceAverage: 73,
    engagementAverage: 68,
    satisfaction: 4.0,
    status: 'attention',
    statusLabel: 'Requer atenção',
    disciplines: ['Auditoria de Qualidade', 'Gestão Lean'],
  ),
  TeacherInfo(
    id: 'teacher-04',
    name: 'Paulo Freitas',
    area: 'Análises Instrumentais',
    campus: 'EurON Paulista',
    classesCount: 3,
    studentsCount: 79,
    attendanceAverage: 90,
    engagementAverage: 86,
    satisfaction: 4.8,
    status: 'success',
    statusLabel: 'Destaque',
    disciplines: ['Cromatografia', 'Métodos Científicos'],
  ),
  TeacherInfo(
    id: 'teacher-05',
    name: 'Fernanda Reis',
    area: 'Boas Práticas Regulatórias',
    campus: 'EurON Paulista',
    classesCount: 2,
    studentsCount: 61,
    attendanceAverage: 84,
    engagementAverage: 80,
    satisfaction: 4.5,
    status: 'success',
    statusLabel: 'Destaque',
    disciplines: ['Regulatório Global'],
  ),
  TeacherInfo(
    id: 'teacher-06',
    name: 'Gabriel Monteiro',
    area: 'Tecnologias Digitais em Saúde',
    campus: 'EurON Butantã',
    classesCount: 2,
    studentsCount: 47,
    attendanceAverage: 69,
    engagementAverage: 62,
    satisfaction: 3.8,
    status: 'attention',
    statusLabel: 'Requer atenção',
    disciplines: ['Dados em Saúde'],
  ),
  TeacherInfo(
    id: 'teacher-07',
    name: 'Helena Prado',
    area: 'Segurança do Paciente',
    campus: 'EurON Sorocaba',
    classesCount: 3,
    studentsCount: 72,
    attendanceAverage: 87,
    engagementAverage: 83,
    satisfaction: 4.6,
    status: 'success',
    statusLabel: 'Destaque',
    disciplines: ['Protocolos Assistenciais'],
  ),
  TeacherInfo(
    id: 'teacher-08',
    name: 'Igor Matos',
    area: 'Pesquisa Aplicada',
    campus: 'EurON Ribeirão',
    classesCount: 2,
    studentsCount: 49,
    attendanceAverage: 76,
    engagementAverage: 71,
    satisfaction: 4.1,
    status: 'info',
    statusLabel: 'Estável',
    disciplines: ['Métodos Científicos', 'Dados em Saúde'],
  ),
];

// ---------------------------------------------------------------------------
// Mensagens dos fóruns (tela de detalhe do fórum)
// ---------------------------------------------------------------------------

const mockForumMessages = [
  ForumMessage(
    id: 'msg-01',
    forumId: 'forum-01',
    authorName: 'Larissa Nogueira',
    authorRole: 'Educanda',
    message:
        'Compartilhei o resumo dos receptores adrenergicos vistos hoje. '
        'Alguem pode revisar o trecho sobre agonistas parciais?',
    timeLabel: 'ha 1h',
  ),
  ForumMessage(
    id: 'msg-02',
    forumId: 'forum-01',
    authorName: 'Prof. Rafael Martins',
    authorRole: 'Educador',
    message:
        'Otimo resumo, Larissa. Lembrem que o agonista parcial compete com o '
        'total e limita a resposta maxima. Vale reforcar com o slide 12.',
    timeLabel: 'ha 40min',
  ),
  ForumMessage(
    id: 'msg-03',
    forumId: 'forum-01',
    authorName: 'Ana Clara Souza',
    authorRole: 'Educanda',
    message: 'Perfeito, isso esclareceu a dúvida da lista de exercicios. Obrigada!',
    timeLabel: 'ha 20min',
  ),
  ForumMessage(
    id: 'msg-04',
    forumId: 'forum-02',
    authorName: 'João Victor',
    authorRole: 'Educando',
    message:
        'Na validação asséptica, qual a frequência recomendada para o media '
        'fill em uma linha de baixa produtividade?',
    timeLabel: 'ha 2h',
  ),
  ForumMessage(
    id: 'msg-05',
    forumId: 'forum-02',
    authorName: 'Ana Duarte',
    authorRole: 'Educadora',
    message:
        'Boa pergunta. O guia recomenda no mínimo duas simulações por semestre '
        'por turno de operacao. Anexei o checklist na próxima aula.',
    timeLabel: 'ha 1h30',
  ),
  ForumMessage(
    id: 'msg-06',
    forumId: 'forum-03',
    authorName: 'Camila Rocha',
    authorRole: 'Educanda',
    message:
        'Subi a versao colaborativa do checklist de auditoria. Deixei destacados '
        'os pontos criticos que caem com mais frequência.',
    timeLabel: 'ha 3h',
  ),
  ForumMessage(
    id: 'msg-07',
    forumId: 'forum-03',
    authorName: 'Thiago Mendes',
    authorRole: 'Educador',
    message: 'Excelente iniciativa. Vou usar esse checklist como base na avaliação.',
    timeLabel: 'ha 2h',
  ),
  ForumMessage(
    id: 'msg-08',
    forumId: 'forum-04',
    authorName: 'Bruno Lima',
    authorRole: 'Educando',
    message:
        'Tenho dúvida em identificar coeluicao em cromatogramas com picos muito '
        'próximos. Alguma dica de leitura?',
    timeLabel: 'ha 4h',
  ),
  ForumMessage(
    id: 'msg-09',
    forumId: 'forum-04',
    authorName: 'Paulo Freitas',
    authorRole: 'Educador',
    message:
        'Observe a resolucao entre picos e o formato da linha de base. Se ficar '
        'em dúvida, ajuste a fase movel e repita a corrida.',
    timeLabel: 'ha 3h',
  ),
  ForumMessage(
    id: 'msg-10',
    forumId: 'forum-05',
    authorName: 'Fernanda Reis',
    authorRole: 'Educadora',
    message:
        'Abri o tópico para consolidarmos a interpretacao das normas ICH Q7. '
        'Postem exemplos praticos que encontrarem no dia a dia.',
    timeLabel: 'ha 5h',
  ),
  ForumMessage(
    id: 'msg-11',
    forumId: 'forum-06',
    authorName: 'Gabriel Monteiro',
    authorRole: 'Educador',
    message:
        'Segue um exemplo de plano lean aplicado a um fluxo de embalagem. '
        'Comentem onde dá para reduzir desperdicio.',
    timeLabel: 'ha 6h',
  ),
];

// ---------------------------------------------------------------------------
// Helpers de busca por id (passagem de parâmetros entre telas)
// ---------------------------------------------------------------------------

final Map<String, TeacherInfo> _teachersById = {
  for (final teacher in mockTeachers) teacher.id: teacher,
};

final Map<String, CourseInfo> _coursesById = {
  for (final course in mockCourses) course.id: course,
};

final Map<String, ClassSummary> _classesById = {
  for (final classSummary in mockClasses) classSummary.id: classSummary,
};

final Map<String, ForumInfo> _forumsById = {
  for (final forum in mockForums) forum.id: forum,
};

final Map<String, SuggestedStudent> _suggestedStudentsById = {
  for (final student in mockSuggestedStudents) student.id: student,
};

TeacherInfo? teacherById(String id) => _teachersById[id];

CourseInfo? courseById(String id) => _coursesById[id];

ClassSummary? classById(String id) => _classesById[id];

ForumInfo? forumById(String id) => _forumsById[id];

SuggestedStudent? suggestedStudentById(String id) =>
    _suggestedStudentsById[id];

/// Disciplinas associadas a um curso.
List<DisciplineInfo> disciplinesForCourse(String courseId) {
  return mockDisciplines
      .where((discipline) => discipline.courseId == courseId)
      .toList();
}

/// Aulas de uma disciplina.
List<LessonInfo> lessonsForDiscipline(String disciplineId) {
  return mockLessons
      .where((lesson) => lesson.disciplineId == disciplineId)
      .toList();
}

/// Fóruns associados a um curso (via suas disciplinas).
List<ForumInfo> forumsForCourse(String courseId) {
  final disciplineIds = disciplinesForCourse(
    courseId,
  ).map((discipline) => discipline.id).toSet();
  return mockForums
      .where((forum) => disciplineIds.contains(forum.disciplineId))
      .toList();
}

/// Nome da disciplina a partir do id (rótulo amigável nas telas).
String disciplineNameById(String disciplineId) {
  final match = mockDisciplines
      .where((discipline) => discipline.id == disciplineId)
      .toList();
  return match.isEmpty ? 'Disciplina' : match.first.name;
}

/// Mensagens de um fórum. Caso não haja mensagens específicas cadastradas,
/// retorna uma mensagem de abertura derivada do próprio tópico.
List<ForumMessage> messagesForForum(ForumInfo forum) {
  final specific = mockForumMessages
      .where((message) => message.forumId == forum.id)
      .toList();
  if (specific.isNotEmpty) {
    return specific;
  }
  return [
    ForumMessage(
      id: '${forum.id}-abertura',
      forumId: forum.id,
      authorName: forum.authorName,
      authorRole: 'Autor do tópico',
      message:
          'Tópico "${forum.title}" aberto para discussao da turma. '
          'Participe deixando dúvidas e contribuicoes.',
      timeLabel: forum.lastActivityLabel,
    ),
  ];
}
