import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../shared/format.dart';
import '../../../shared/responsive/responsive_grid.dart';
import '../../../shared/widgets/detail_scaffold.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/simple_bar_chart.dart';
import '../../../shared/widgets/status_badge.dart';

/// Detalhe de acompanhamento individual de um educando.
/// Recebe o [studentId] como parâmetro de rota.
class AlunoDetailScreen extends StatelessWidget {
  const AlunoDetailScreen({required this.studentId, super.key});

  final String studentId;

  @override
  Widget build(BuildContext context) {
    final student = suggestedStudentById(studentId);
    if (student == null) {
      return const DetailScaffold(
        title: 'Educando não encontrado',
        child: Text('Não localizamos este educando na base simulada.'),
      );
    }

    return DetailScaffold(
      title: student.name,
      subtitle: student.className,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveGrid(
            minItemWidth: 190,
            childAspectRatio: 1.2,
            children: [
              MetricCard(
                label: 'Presença',
                value: '${student.attendance.toStringAsFixed(0)}%',
                helper: 'Últimos 30 dias',
                icon: Icons.event_available_outlined,
                status: student.attendance < 60 ? 'critical' : 'info',
              ),
              MetricCard(
                label: 'Engajamento',
                value: '${student.engagement.toStringAsFixed(0)}%',
                helper: 'Moodle + missões',
                icon: Icons.trending_up,
                status: student.engagement < 60 ? 'critical' : 'success',
              ),
              MetricCard(
                label: 'Última interação',
                value: '${student.lastInteractionDays}d',
                helper: 'Dias desde o último acesso',
                icon: Icons.schedule_outlined,
                status: student.lastInteractionDays > 7
                    ? 'attention'
                    : 'neutral',
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Presença x Engajamento',
            subtitle: 'Comparativo dos principais indicadores.',
            child: SimpleBarChart(
              data: [
                BarDatum(
                  label: 'Presença',
                  value: student.attendance,
                  status: student.attendance < 60 ? 'critical' : 'info',
                ),
                BarDatum(
                  label: 'Engajamento',
                  value: student.engagement,
                  status: student.engagement < 60 ? 'critical' : 'success',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionPanel(
            title: 'Plano de cuidado',
            subtitle: 'Prioridade e próximo passo sugerido.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flag_outlined),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        student.primaryNeed,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    StatusBadge(
                      label: riskLabelPt(student.riskLevel),
                      status: student.riskLevel,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Recomendação: manter contato próximo e registrar a evolução '
                  'no acompanhamento semanal da turma.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}