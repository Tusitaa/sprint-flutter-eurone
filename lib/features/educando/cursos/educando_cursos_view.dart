import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/mock_data.dart';
import '../../../shared/widgets/euri_mascot.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/status_badge.dart';

/// Tela 2 do Educando: visualização unificada de cursos e tópicos de fórum.
/// Cada item abre uma tela de detalhe correspondente (passagem de parâmetro).
class EducandoCursosView extends StatelessWidget {
  const EducandoCursosView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cursos e fóruns',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Seus cursos e os fóruns da turma em um só lugar.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        const EuriHint(
          pose: EuriPose.curioso,
          message: 'Explore seus cursos e fóruns — toque em um item para '
              'mergulhar no conteúdo.',
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Meus cursos',
          subtitle: 'Toque em um curso para ver disciplinas, aulas e fóruns.',
          child: Column(
            children: [
              for (final course in mockCourses)
                ListTile(
                  leading: const Icon(Icons.menu_book_outlined),
                  title: Text(course.name),
                  subtitle: Text('${course.track} • Fase ${course.phase}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/educando/curso/${course.id}'),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Fóruns em destaque',
          subtitle: 'Participe das discussões abertas pela sua turma.',
          child: Column(
            children: [
              for (final forum in mockForums)
                ListTile(
                  leading: const Icon(Icons.forum_outlined),
                  title: Text(forum.title),
                  subtitle: Text(
                    '${disciplineNameById(forum.disciplineId)} • '
                    'por ${forum.authorName}',
                  ),
                  trailing: StatusBadge(
                    label: '${forum.replies} respostas',
                    status: 'info',
                  ),
                  onTap: () => context.push('/educando/forum/${forum.id}'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
