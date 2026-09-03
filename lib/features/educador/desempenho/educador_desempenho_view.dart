import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/models/dashboard_models.dart';
import '../../../shared/format.dart';
import '../../../shared/responsive/responsive_grid.dart';
import '../../../shared/widgets/euri_mascot.dart';
import '../../../shared/widgets/filter_bar.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/status_badge.dart';

/// Tela 1 do Educador: painel com informações dos alunos e gráficos de
/// desempenho.
///
/// O gráfico de dispersão, a lista de acompanhamento e a tela de detalhe usam
/// a MESMA fonte de dados ([mockSuggestedStudents]) e o mesmo classificador de
/// risco, garantindo que o mesmo educando apareça sempre com os mesmos números.
class EducadorDesempenhoView extends StatefulWidget {
  const EducadorDesempenhoView({super.key});

  @override
  State<EducadorDesempenhoView> createState() => _EducadorDesempenhoViewState();
}

class _EducadorDesempenhoViewState extends State<EducadorDesempenhoView> {
  String _selectedRisk = 'all';

  @override
  Widget build(BuildContext context) {
    final students = _filteredStudents();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Painel de desempenho',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Acompanhamento de presença, engajamento e cuidado dos seus educandos.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        const EuriHint(
          pose: EuriPose.anotando,
          message: 'Acompanhe cada educando de perto e registre os próximos '
              'passos de cuidado.',
        ),
        const SizedBox(height: 16),
        ResponsiveGrid(
          minItemWidth: 190,
          childAspectRatio: 1.2,
          children: [
            MetricCard(
              label: 'Educandos',
              value: '${mockSuggestedStudents.length}',
              helper: 'Em acompanhamento',
              icon: Icons.groups_outlined,
              status: 'neutral',
            ),
            const MetricCard(
              label: 'Assiduidade',
              value: '82%',
              helper: 'Últimos 30 dias',
              icon: Icons.event_note_outlined,
              status: 'info',
              trend: '+2.1%',
            ),
            const MetricCard(
              label: 'Engajamento',
              value: '76%',
              helper: 'Moodle + missões',
              icon: Icons.trending_up,
              status: 'success',
              trend: '+3.4%',
            ),
            const MetricCard(
              label: 'Alertas',
              value: '4',
              helper: '2 críticos',
              icon: Icons.warning_amber_outlined,
              status: 'critical',
              trend: '-1',
            ),
          ],
        ),
        const SizedBox(height: 16),
        FilterBar(
          title: 'Nível de cuidado',
          options: mockFilterRiskLevels,
          selectedId: _selectedRisk,
          onChanged: (value) => setState(() => _selectedRisk = value),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 960;
            final chart = _EngagementScatterCard(students: students);
            const qr = _QrGeneratorCard();

            if (compact) {
              return Column(children: [chart, const SizedBox(height: 12), qr]);
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: chart),
                const SizedBox(width: 12),
                Expanded(child: qr),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Acompanhamento individual',
          subtitle: 'Toque em um educando para abrir o detalhe.',
          child: students.isEmpty
              ? const Text('Nenhum educando neste filtro.')
              : Column(
                  children: [
                    for (final student in students)
                      ListTile(
                        leading: const Icon(Icons.person_search_outlined),
                        title: Text(student.name),
                        subtitle: Text(
                          '${student.className} • '
                          'presença ${student.attendance.toStringAsFixed(0)}% • '
                          'engajamento ${student.engagement.toStringAsFixed(0)}%',
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
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Alertas explicáveis',
          subtitle: 'Cada alerta traz contexto e ação sugerida.',
          child: Column(
            children: [
              for (final alert
                  in mockAlerts.where((item) => item.level != 'baixo').take(4))
                ListTile(
                  leading: Icon(
                    alert.level == 'critico'
                        ? Icons.error_outline
                        : Icons.warning_amber_outlined,
                  ),
                  title: Text(alert.title),
                  subtitle: Text('${alert.reason}\n${alert.recommendedAction}'),
                  isThreeLine: true,
                  trailing: StatusBadge(
                    label: riskLabelPt(alert.level),
                    status: alert.level,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Fonte única de educandos, filtrada pelo nível de cuidado selecionado.
  List<SuggestedStudent> _filteredStudents() {
    if (_selectedRisk == 'all') {
      return mockSuggestedStudents;
    }
    return mockSuggestedStudents
        .where((student) => riskFilterId(student.riskLevel) == _selectedRisk)
        .toList();
  }
}

class _EngagementScatterCard extends StatelessWidget {
  const _EngagementScatterCard({required this.students});

  final List<SuggestedStudent> students;

  @override
  Widget build(BuildContext context) {
    final data = students.isEmpty ? mockSuggestedStudents : students;

    return SectionPanel(
      title: 'Presença x Engajamento',
      subtitle: 'Cada educando com sua presença e engajamento, colorido pelo '
          'nível de cuidado.',
      child: Column(
        children: [
          for (final student in data) ...[
            _StudentEngagementBars(
              student: student,
              color: _riskColor(student.riskLevel),
            ),
            if (student != data.last) const Divider(height: 20),
          ],
          const SizedBox(height: 10),
          Text(
            'Educandos analisados: ${data.length}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Color _riskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'critico':
        return const Color(0xFFDC2626);
      case 'atencao':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF16A34A);
    }
  }
}

/// Barras de presença e engajamento de um educando, coloridas pelo nível de
/// cuidado.
class _StudentEngagementBars extends StatelessWidget {
  const _StudentEngagementBars({required this.student, required this.color});

  final SuggestedStudent student;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                student.name,
                style: theme.textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            StatusBadge(
              label: riskLabelPt(student.riskLevel),
              status: student.riskLevel,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _MetricBar(label: 'Presença', value: student.attendance, color: color),
        const SizedBox(height: 6),
        _MetricBar(
          label: 'Engajamento',
          value: student.engagement,
          color: color,
        ),
      ],
    );
  }
}

/// Uma barra horizontal rotulada (0–100%).
class _MetricBar extends StatelessWidget {
  const _MetricBar({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SizedBox(
          width: 92,
          child: Text(label, style: theme.textTheme.bodySmall),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (value / 100).clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            '${value.toStringAsFixed(0)}%',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _QrGeneratorCard extends StatelessWidget {
  const _QrGeneratorCard();

  @override
  Widget build(BuildContext context) {
    const qrData = 'euroone://checkin/turma-euron-a/aula-2026-05-03';

    return SectionPanel(
      title: 'QR da aula',
      subtitle: 'Código válido para o check-in da turma atual.',
      child: Column(
        children: [
          QrImageView(data: qrData, size: 180, backgroundColor: Colors.white),
          const SizedBox(height: 10),
          const Text(
            'Atualize o QR a cada início de aula para manter a confiabilidade '
            'dos registros.',
          ),
        ],
      ),
    );
  }
}
