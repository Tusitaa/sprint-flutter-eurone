import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/mock_data.dart';
import '../../../shared/responsive/responsive_grid.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/simple_bar_chart.dart';
import '../../../shared/widgets/status_badge.dart';

/// Tela 1 da Gestão: painel com informações dos professores e gráficos
/// estatísticos de engajamento por educador.
class GestaoProfessoresView extends StatelessWidget {
  const GestaoProfessoresView({super.key});

  @override
  Widget build(BuildContext context) {
    final totalStudents = mockTeachers.fold<int>(
      0,
      (sum, teacher) => sum + teacher.studentsCount,
    );
    final avgEngagement =
        mockTeachers.fold<double>(
          0,
          (sum, teacher) => sum + teacher.engagementAverage,
        ) /
        mockTeachers.length;
    final destaques = mockTeachers
        .where((teacher) => teacher.status == 'success')
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Painel de professores',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Acompanhe o corpo docente e o engajamento gerado em cada área.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        ResponsiveGrid(
          minItemWidth: 190,
          childAspectRatio: 1.2,
          children: [
            MetricCard(
              label: 'Professores',
              value: '${mockTeachers.length}',
              helper: 'Ativos na rede EurON',
              icon: Icons.badge_outlined,
              status: 'neutral',
            ),
            MetricCard(
              label: 'Educandos atendidos',
              value: '$totalStudents',
              helper: 'Somatório das turmas',
              icon: Icons.groups_2_outlined,
              status: 'info',
            ),
            MetricCard(
              label: 'Engajamento médio',
              value: '${avgEngagement.toStringAsFixed(0)}%',
              helper: 'Média do corpo docente',
              icon: Icons.trending_up,
              status: 'success',
            ),
            MetricCard(
              label: 'Destaques',
              value: '$destaques',
              helper: 'Professores em evidência',
              icon: Icons.workspace_premium_outlined,
              status: 'success',
            ),
          ],
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Engajamento por professor',
          subtitle: 'Média de engajamento das turmas de cada educador.',
          child: SimpleBarChart(
            data: [
              for (final teacher in mockTeachers)
                BarDatum(
                  label: _shortName(teacher.name),
                  value: teacher.engagementAverage,
                  status: teacher.status,
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Corpo docente',
          subtitle: 'Toque em um professor para ver o detalhamento.',
          child: Column(
            children: [
              for (final teacher in mockTeachers)
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(teacher.name),
                  subtitle: Text(
                    '${teacher.area} • ${teacher.classesCount} turmas • '
                    '${teacher.studentsCount} educandos',
                  ),
                  trailing: Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      StatusBadge(
                        label: teacher.statusLabel,
                        status: teacher.status,
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () => context.push('/gestao/professor/${teacher.id}'),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _shortName(String name) {
    final withoutTitle = name.replaceFirst('Prof. ', '');
    return withoutTitle.split(RegExp(r'\s+')).first;
  }
}
