class Mission {
  const Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.completed,
    required this.dueLabel,
  });

  final String id;
  final String title;
  final String description;
  final int points;
  final bool completed;
  final String dueLabel;
}

class RewardItem {
  const RewardItem({
    required this.id,
    required this.title,
    required this.description,
    required this.costPoints,
    required this.unlocked,
  });

  final String id;
  final String title;
  final String description;
  final int costPoints;
  final bool unlocked;
}

class DashboardMetric {
  const DashboardMetric({
    required this.id,
    required this.label,
    required this.value,
    required this.helper,
    required this.status,
    this.trend,
  });

  final String id;
  final String label;
  final String value;
  final String helper;
  final String status;
  final String? trend;
}

class EducandoSnapshot {
  const EducandoSnapshot({
    required this.studentName,
    required this.progress,
    required this.faltas,
    required this.entregasPendentes,
    required this.points,
    required this.level,
    required this.streakDays,
  });

  final String studentName;
  final int progress;
  final int faltas;
  final int entregasPendentes;
  final int points;
  final int level;
  final int streakDays;
}

class ClassSummary {
  const ClassSummary({
    required this.id,
    required this.name,
    required this.students,
    required this.attendanceAverage,
    required this.engagementAverage,
    required this.alerts,
    required this.riskLabel,
    required this.evolutionLabel,
  });

  final String id;
  final String name;
  final int students;
  final double attendanceAverage;
  final double engagementAverage;
  final int alerts;
  final String riskLabel;
  final String evolutionLabel;
}

class AlertItem {
  const AlertItem({
    required this.id,
    required this.studentName,
    required this.level,
    required this.title,
    required this.reason,
    required this.recommendedAction,
  });

  final String id;
  final String studentName;
  final String level;
  final String title;
  final String reason;
  final String recommendedAction;
}

class SuggestedStudent {
  const SuggestedStudent({
    required this.id,
    required this.name,
    required this.className,
    required this.attendance,
    required this.engagement,
    required this.riskLevel,
    required this.primaryNeed,
    required this.lastInteractionDays,
  });

  final String id;
  final String name;
  final String className;
  final double attendance;
  final double engagement;
  final String riskLevel;
  final String primaryNeed;
  final int lastInteractionDays;
}

class CourseInfo {
  const CourseInfo({
    required this.id,
    required this.name,
    required this.track,
    required this.phase,
  });

  final String id;
  final String name;
  final String track;
  final String phase;
}

class DisciplineInfo {
  const DisciplineInfo({
    required this.id,
    required this.courseId,
    required this.name,
    required this.teacherName,
  });

  final String id;
  final String courseId;
  final String name;
  final String teacherName;
}

class LessonInfo {
  const LessonInfo({
    required this.id,
    required this.disciplineId,
    required this.title,
    required this.dateLabel,
    required this.format,
    required this.durationMinutes,
  });

  final String id;
  final String disciplineId;
  final String title;
  final String dateLabel;
  final String format;
  final int durationMinutes;
}

class ForumInfo {
  const ForumInfo({
    required this.id,
    required this.disciplineId,
    required this.title,
    required this.authorName,
    required this.replies,
    required this.lastActivityLabel,
  });

  final String id;
  final String disciplineId;
  final String title;
  final String authorName;
  final int replies;
  final String lastActivityLabel;
}

class AssignmentInfo {
  const AssignmentInfo({
    required this.id,
    required this.disciplineId,
    required this.title,
    required this.dueLabel,
    required this.status,
    required this.scoreLabel,
  });

  final String id;
  final String disciplineId;
  final String title;
  final String dueLabel;
  final String status;
  final String scoreLabel;
}

class AttendanceRecord {
  const AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.classId,
    required this.dateLabel,
    required this.present,
  });

  final String id;
  final String studentId;
  final String classId;
  final String dateLabel;
  final bool present;
}

class EvolutionPoint {
  const EvolutionPoint({
    required this.id,
    required this.label,
    required this.value,
  });

  final String id;
  final String label;
  final double value;
}

class CarePriority {
  const CarePriority({
    required this.studentName,
    required this.level,
    required this.reason,
    required this.nextAction,
  });

  final String studentName;
  final String level;
  final String reason;
  final String nextAction;
}

class ActionSuggestion {
  const ActionSuggestion({
    required this.title,
    required this.description,
    required this.expectedImpact,
  });

  final String title;
  final String description;
  final String expectedImpact;
}

class FilterOption {
  const FilterOption({required this.id, required this.label});

  final String id;
  final String label;
}

class EngagementDrop {
  const EngagementDrop({
    required this.className,
    required this.deltaLabel,
    required this.reason,
  });

  final String className;
  final String deltaLabel;
  final String reason;
}

/// Informações consolidadas de um educador, usadas no painel da Gestão.
class TeacherInfo {
  const TeacherInfo({
    required this.id,
    required this.name,
    required this.area,
    required this.campus,
    required this.classesCount,
    required this.studentsCount,
    required this.attendanceAverage,
    required this.engagementAverage,
    required this.satisfaction,
    required this.status,
    required this.statusLabel,
    required this.disciplines,
  });

  final String id;
  final String name;
  final String area;
  final String campus;
  final int classesCount;
  final int studentsCount;
  final double attendanceAverage;
  final double engagementAverage;

  /// Nota de satisfação da trilha (0 a 5).
  final double satisfaction;

  /// Chave de cor para o [StatusBadge]: success, info, attention, critical.
  final String status;
  final String statusLabel;
  final List<String> disciplines;
}

/// Mensagem de um tópico de fórum, exibida na tela de detalhe do fórum.
class ForumMessage {
  const ForumMessage({
    required this.id,
    required this.forumId,
    required this.authorName,
    required this.authorRole,
    required this.message,
    required this.timeLabel,
  });

  final String id;
  final String forumId;
  final String authorName;
  final String authorRole;
  final String message;
  final String timeLabel;
}
