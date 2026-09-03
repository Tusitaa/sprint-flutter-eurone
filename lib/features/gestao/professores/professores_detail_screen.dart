import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../shared/responsive/responsive_grid.dart';
import '../../../shared/widgets/detail_scaffold.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/simple_bar_chart.dart';
import '../../../shared/widgets/status_badge.dart';

/// Detalhe de um professor, aberto a partir do painel da Gestão.
/// Recebe o [teacherId] como parâmetro de rota.
class ProfessorDetailScreen extends StatelessWidget {
  const ProfessorDetailScreen({required this.teacherId, super.key});

  final String teacherId;

  @override
  Widget build(BuildContext context) {
    final teacher = teacherById(teacherId);
    if (teacher == null) {
      return const DetailScaffold(
        title: 'Professor não encontrado',
        child: Text('Não localizamos este professor na base simulada.'),
      );
    }

    return DetailScaffold(
      title: teacher.name,
      subtitle: '${teacher.area} • ${teacher.campus}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveGrid(
            minItemWidth: 190,
            childAspectRatio: 1.2,
            children: [
              MetricCard(
                label: 'Turmas',
                value: '${teacher.classesCount}',
                helper: 'Sob responsabilidade',
                icon: Icons.class_outlined,
                status: 'neutral',
              ),
              MetricCard(
                label: 'Educandos',
                value: '${teacher.studentsCount}',
                helper: 'Total atendido',
                icon: Icons.groups_outlined,
                status: 'info',
              ),
              MetricCard(
                label: 'Satisfação',
                value: teacher.satisfaction.toStringAsFixed(1),
                helper: 'Nota da trilha (0 a 5)',
                icon: Icons.star_outline,
                status: teacher.satisfaction >= 4.5 ? 'success' : 'attention',
              ),
              MetricCard(
                label: 'Situação',
                value: teacher.statusLabel,
                helper: 'Classificação atual',
                icon: Icons.flag_outlined,
                status: teacher.status,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Assiduidade x Engajamento',
            subtitle: 'Médias das turmas do professor.',
            child: SimpleBarChart(
              data: [
                BarDatum(
                  label: 'Assiduidade',
                  value: teacher.attendanceAverage,
                  status: 'info',
                ),
                BarDatum(
                  label: 'Engajamento',
                  value: teacher.engagementAverage,
                  status: teacher.status,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Disciplinas',
            subtitle: 'Áreas ministradas por este professor.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final discipline in teacher.disciplines)
                  StatusBadge(label: discipline, status: 'neutral'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}