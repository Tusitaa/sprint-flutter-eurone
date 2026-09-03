import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/models/dashboard_models.dart';
import '../../../shared/format.dart';
import '../../../shared/responsive/responsive_grid.dart';
import '../../../shared/widgets/euri_mascot.dart';
import '../../../shared/widgets/filter_bar.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/simple_bar_chart.dart';
import '../../../shared/widgets/status_badge.dart';

/// Tela 2 da Gestão: visão geral de alunos e métricas do sistema.
class GestaoVisaoView extends StatefulWidget {
  const GestaoVisaoView({super.key});

  @override
  State<GestaoVisaoView> createState() => _GestaoVisaoViewState();
}

class _GestaoVisaoViewState extends State<GestaoVisaoView> {
  String _selectedClass = 'all';
  String _selectedRisk = 'all';

  @override
  Widget build(BuildContext context) {
    final classes = _filteredClasses();
    final drops = _filteredDrops();
    final consolidatedAlerts = _filteredAlerts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visão executiva institucional',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Acompanhe saúde acadêmica, risco e evolução das turmas em um único painel.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        const EuriHint(
          pose: EuriPose.apresentando,
          message: 'Sua visão executiva das turmas: indicadores, evolução e '
              'alertas em um só lugar.',
        ),
        const SizedBox(height: 16),
        const ResponsiveGrid(
          minItemWidth: 190,
          childAspectRatio: 1.2,
          children: [
            MetricCard(
              label: 'Turmas',
              value: '10',
              helper: 'Monitoradas',
              icon: Icons.account_tree_outlined,
              status: 'neutral',
            ),
            MetricCard(
              label: 'Educandos',
              value: '286',
              helper: 'Ativos no programa',
              icon: Icons.groups_2_outlined,
              status: 'info',
              trend: '+12',
            ),
            MetricCard(
              label: 'Assiduidade média',
              value: '82%',
              helper: 'Todas as turmas',
              icon: Icons.event_available_outlined,
              status: 'success',
              trend: '+2.1%',
            ),
            MetricCard(
              label: 'Alertas abertos',
              value: '13',
              helper: '6 críticos',
              icon: Icons.crisis_alert_outlined,
              status: 'critical',
              trend: '-1',
            ),
          ],
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Evolução do engajamento institucional',
          subtitle: 'Média consolidada das últimas 10 semanas.',
          child: SimpleBarChart(
            height: 220,
            data: [
              for (final point in mockEvolution)
                BarDatum(label: point.label, value: point.value),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilterBar(
          title: 'Filtro por turma',
          options: mockFilterClasses,
          selectedId: _selectedClass,
          onChanged: (value) => setState(() => _selectedClass = value),
        ),
        const SizedBox(height: 10),
        FilterBar(
          title: 'Filtro por risco',
          options: mockFilterRiskLevels,
          selectedId: _selectedRisk,
          onChanged: (value) => setState(() => _selectedRisk = value),
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Saúde das turmas',
          subtitle: 'Toque em uma turma para abrir o detalhamento.',
          child: classes.isEmpty
              ? const Text('Nenhuma turma encontrada para o filtro selecionado.')
              : Column(
                  children: [
                    for (final classSummary in classes)
                      ListTile(
                        leading: const Icon(Icons.insights_outlined),
                        title: Text(classSummary.name),
                        subtitle: Text(
                          '${classSummary.students} educandos • '
                          'assiduidade ${classSummary.attendanceAverage.toStringAsFixed(0)}% • '
                          'engajamento ${classSummary.engagementAverage.toStringAsFixed(0)}%',
                        ),
                        trailing: Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            StatusBadge(
                              label: riskLabelPt(classSummary.riskLabel),
                              status: classSummary.riskLabel,
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () =>
                            context.push('/gestao/turma/${classSummary.id}'),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 980;
            final evolutionPanel = SectionPanel(
              title: 'Top evolução',
              subtitle: 'Turmas com maior crescimento no ciclo.',
              child: Column(
                children: [
                  for (final item in mockGestaoTopEvolution)
                    ListTile(
                      leading: const Icon(Icons.trending_up),
                      title: Text(item.$1),
                      trailing: StatusBadge(label: item.$2, status: 'success'),
                    ),
                ],
              ),
            );

            final dropsPanel = SectionPanel(
              title: 'Quedas de engajamento',
              subtitle: 'Sinais de alerta para intervenção tática.',
              child: drops.isEmpty
                  ? const Text('Sem quedas relevantes para este recorte.')
                  : Column(
                      children: [
                        for (final drop in drops)
                          ListTile(
                            leading: const Icon(Icons.trending_down),
                            title: Text(drop.className),
                            subtitle: Text(drop.reason),
                            trailing: StatusBadge(
                              label: drop.deltaLabel,
                              status: 'attention',
                            ),
                          ),
                      ],
                    ),
            );

            if (compact) {
              return Column(
                children: [
                  evolutionPanel,
                  const SizedBox(height: 12),
                  dropsPanel,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: evolutionPanel),
                const SizedBox(width: 12),
                Expanded(child: dropsPanel),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Alertas consolidados',
          subtitle: 'Concentrado de prioridades para decisão executiva.',
          child: consolidatedAlerts.isEmpty
              ? const Text('Sem alertas para este filtro no momento.')
              : Column(
                  children: [
                    for (final alert in consolidatedAlerts)
                      ListTile(
                        leading: Icon(
                          alert.level == 'critico'
                              ? Icons.error_outline
                              : Icons.warning_amber_outlined,
                        ),
                        title: Text(alert.studentName),
                        subtitle: Text(alert.reason),
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

  List<ClassSummary> _filteredClasses() {
    return mockClasses.where((item) {
      final classMatch = _selectedClass == 'all' || item.id == _selectedClass;
      if (!classMatch) {
        return false;
      }
      if (_selectedRisk == 'all') {
        return true;
      }
      return riskFilterId(item.riskLabel) == _selectedRisk;
    }).toList();
  }

  List<EngagementDrop> _filteredDrops() {
    if (_selectedClass == 'all') {
      return mockGestaoEngagementDrops;
    }
    final selectedClassName = mockClasses
        .where((item) => item.id == _selectedClass)
        .map((item) => item.name)
        .toList();
    if (selectedClassName.isEmpty) {
      return const [];
    }
    final targetName = selectedClassName.first;
    return mockGestaoEngagementDrops
        .where((item) => item.className == targetName)
        .toList();
  }

  List<AlertItem> _filteredAlerts() {
    if (_selectedRisk == 'all') {
      return mockAlerts.take(6).toList();
    }
    final expected = _selectedRisk == 'critical'
        ? 'critico'
        : _selectedRisk == 'attention'
        ? 'atencao'
        : 'baixo';
    return mockAlerts.where((item) => item.level == expected).take(6).toList();
  }
}
