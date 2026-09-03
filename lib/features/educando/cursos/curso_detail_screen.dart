import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/models/dashboard_models.dart';
import '../../../shared/widgets/detail_scaffold.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/status_badge.dart';

/// Detalhe de um curso, aberto a partir da listagem do Educando.
/// Recebe o [courseId] como parâmetro de rota.
class CursoDetailScreen extends StatelessWidget {
  const CursoDetailScreen({required this.courseId, super.key});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final course = courseById(courseId);
    if (course == null) {
      return const DetailScaffold(
        title: 'Curso não encontrado',
        child: Text('Não localizamos este curso na base simulada.'),
      );
    }

    final disciplines = disciplinesForCourse(course.id);
    final forums = forumsForCourse(course.id);

    return DetailScaffold(
      title: course.name,
      subtitle: '${course.track} • Fase ${course.phase}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionPanel(
            title: 'Sobre o curso',
            subtitle: 'Trilha ${course.track}',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                StatusBadge(label: 'Fase ${course.phase}', status: 'info'),
                StatusBadge(
                  label: '${disciplines.length} disciplinas',
                  status: 'neutral',
                ),
                StatusBadge(
                  label: '${forums.length} fóruns',
                  status: 'success',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Disciplinas e aulas',
            subtitle: 'Conteúdo programático do curso.',
            child: disciplines.isEmpty
                ? const Text('Sem disciplinas cadastradas para este curso.')
                : Column(
                    children: [
                      for (final discipline in disciplines)
                        _DisciplineTile(discipline: discipline),
                    ],
                  ),
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Fóruns do curso',
            subtitle: 'Discussões vinculadas às disciplinas.',
            child: forums.isEmpty
                ? const Text('Nenhum fórum aberto para este curso ainda.')
                : Column(
                    children: [
                      for (final forum in forums)
                        ListTile(
                          leading: const Icon(Icons.forum_outlined),
                          title: Text(forum.title),
                          subtitle: Text('por ${forum.authorName}'),
                          trailing: StatusBadge(
                            label: '${forum.replies} respostas',
                            status: 'info',
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _DisciplineTile extends StatelessWidget {
  const _DisciplineTile({required this.discipline});

  final DisciplineInfo discipline;

  @override
  Widget build(BuildContext context) {
    final lessons = lessonsForDiscipline(discipline.id);
    return ExpansionTile(
      leading: const Icon(Icons.book_outlined),
      title: Text(discipline.name),
      subtitle: Text('Educador: ${discipline.teacherName}'),
      childrenPadding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
      children: [
        for (final lesson in lessons)
          ListTile(
            dense: true,
            leading: const Icon(Icons.play_lesson_outlined, size: 20),
            title: Text(lesson.title),
            subtitle: Text(
              '${lesson.dateLabel} • ${lesson.format} • ${lesson.durationMinutes} min',
            ),
          ),
        if (lessons.isEmpty)
          const ListTile(
            dense: true,
            title: Text('Sem aulas cadastradas nesta disciplina.'),
          ),
      ],
    );
  }
}
