import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../shared/format.dart';
import '../../shared/responsive/responsive_grid.dart';
import '../../shared/widgets/detail_scaffold.dart';
import '../../shared/widgets/metric_card.dart';
import '../../shared/widgets/section_panel.dart';
import '../../shared/widgets/simple_bar_chart.dart';
import '../../shared/widgets/status_badge.dart';

/// Detalhe de uma turma, aberto tanto pela área do Educador quanto da Gestão.
/// Recebe o [classId] como parâmetro de rota.
class TurmaDetailScreen extends StatelessWidget {
  const TurmaDetailScreen({required this.classId, super.key});

  final String classId;

  @override
  Widget build(BuildContext context) {
    final classSummary = classById(classId);
    if (classSummary == null) {
      return const DetailScaffold(
        title: 'Turma não encontrada',
        child: Text('Não localizamos esta turma na base simulada.'),
      );
    }

    final students = mockSuggestedStudents
        .where((student) => student.className == classSummary.name)
        .toList();

    return DetailScaffold(
      title: classSummary.name,
      subtitle: '${classSummary.students} educandos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveGrid(
            minItemWidth: 190,
            childAspectRatio: 1.2,
            children: [
              MetricCard(
                label: 'Assiduidade',
                value: '${classSummary.attendanceAverage.toStringAsFixed(0)}%',
                helper: 'Média da turma',
                icon: Icons.event_available_outlined,
                status: 'info',
              ),
              MetricCard(
                label: 'Engajamento',
                value: '${classSummary.engagementAverage.toStringAsFixed(0)}%',
                helper: 'Moodle + missões',
                icon: Icons.trending_up,
                status: 'success',
              ),
              MetricCard(
                label: 'Alertas',
                value: '${classSummary.alerts}',
                helper: 'Em acompanhamento',
                icon: Icons.warning_amber_outlined,
                status: classSummary.alerts >= 6 ? 'critical' : 'attention',
              ),
              MetricCard(
                label: 'Evolução',
                value: classSummary.evolutionLabel,
                helper: 'Comparativo mensal',
                icon: Icons.insights_outlined,
                status: classSummary.evolutionLabel.startsWith('-')
                    ? 'attention'
                    : 'success',
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Indicadores da turma',
            subtitle: 'Assiduidade e engajamento médios.',
            child: SimpleBarChart(
              data: [
                BarDatum(
                  label: 'Assiduidade',
                  value: classSummary.attendanceAverage,
                  status: 'info',
                ),
                BarDatum(
                  label: 'Engajamento',
                  value: classSummary.engagementAverage,
                  status: 'success',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Educandos da turma',
            subtitle: 'Toque em um educando para ver o acompanhamento.',
            child: students.isEmpty
                ? const Text(
                    'Nenhum educando em destaque cadastrado para esta turma.',
                  )
                : Column(
                    children: [
                      for (final student in students)
                        ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: Text(student.name),
                          subtitle: Text(
                            'Presença ${student.attendance.toStringAsFixed(0)}% • '
                            'Engajamento ${student.engagement.toStringAsFixed(0)}%',
                          ),
                          trailing: StatusBadge(
                            label: riskLabelPt(student.riskLevel),
                            status: student.riskLevel,
                          ),
                          onTap: () =>
                              context.push('/educador/aluno/${student.id}'),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
