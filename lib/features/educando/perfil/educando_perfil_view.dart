import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/mock_data.dart';
import '../../auth/auth_controller.dart';
import '../../../shared/responsive/responsive_grid.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/status_badge.dart';

/// Tela 1 do Educando: dados do usuário, progresso, conquistas/itens
/// adquiridos e missões em andamento.
class EducandoPerfilView extends ConsumerWidget {
  const EducandoPerfilView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = ref.watch(authControllerProvider).user;
    final snapshot = mockEducandoSnapshot;
    final userName = user?.name ?? snapshot.studentName;

    final unlockedRewards = mockRewards
        .where((reward) => reward.unlocked)
        .toList();
    final pendingMissions = mockMissions
        .where((mission) => !mission.completed)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meu painel',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Acompanhe seu progresso, conquistas e missões da trilha.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        // Cabeçalho com identificação do educando.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    _initials(userName),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${user?.learningTrack ?? 'Trilha de Saúde'} • '
                        '${user?.className ?? 'Turma EURON A'}',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${user?.campus ?? 'EurON Paulista'} • Nível ${snapshot.level}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: 'Streak ${snapshot.streakDays} dias',
                  status: 'info',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ResponsiveGrid(
          minItemWidth: 190,
          childAspectRatio: 1.18,
          children: [
            MetricCard(
              label: 'Pontos',
              value: '${snapshot.points}',
              helper: 'Nível ${snapshot.level} ativo',
              icon: Icons.stars_outlined,
              status: 'success',
              trend: '+180',
            ),
            MetricCard(
              label: 'Progresso',
              value: '${snapshot.progress}%',
              helper: 'Meta mensal: 85%',
              icon: Icons.trending_up_outlined,
              status: 'info',
              trend: '+6%',
            ),
            MetricCard(
              label: 'Faltas',
              value: '${snapshot.faltas}',
              helper: 'Limite recomendado: até 3',
              icon: Icons.event_busy_outlined,
              status: snapshot.faltas > 3 ? 'critical' : 'attention',
              trend: '-1',
            ),
            MetricCard(
              label: 'Entregas pendentes',
              value: '${snapshot.entregasPendentes}',
              helper: 'Priorize as tarefas de hoje',
              icon: Icons.assignment_late_outlined,
              status: snapshot.entregasPendentes > 3 ? 'attention' : 'success',
              trend: '-2',
            ),
          ],
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Progresso da trilha',
          subtitle: 'Visão rápida das metas acadêmicas da semana.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: snapshot.progress / 100,
                minHeight: 10,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 6),
              Text(
                '${snapshot.progress}% concluído da trilha atual',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  StatusBadge(label: 'Ritmo consistente', status: 'success'),
                  StatusBadge(label: 'Sem alerta crítico', status: 'neutral'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Conquistas e itens adquiridos',
          subtitle: 'Recompensas desbloqueadas pelo seu engajamento.',
          child: unlockedRewards.isEmpty
              ? const Text(
                  'Continue participando para liberar novas conquistas.',
                )
              : Column(
                  children: [
                    for (final reward in unlockedRewards)
                      ListTile(
                        leading: const Icon(Icons.emoji_events_outlined),
                        title: Text(reward.title),
                        subtitle: Text(reward.description),
                        trailing: StatusBadge(
                          label: '${reward.costPoints} pts',
                          status: 'success',
                        ),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Missões em andamento',
          subtitle: 'Conquiste pontos com pequenas entregas diárias.',
          child: pendingMissions.isEmpty
              ? const Text(
                  'Você está com tudo em dia. Que tal apoiar um colega no fórum?',
                )
              : Column(
                  children: [
                    for (final mission in pendingMissions)
                      ListTile(
                        leading: const Icon(Icons.flag_outlined),
                        title: Text(mission.title),
                        subtitle: Text(
                          '${mission.description} • ${mission.dueLabel}',
                        ),
                        trailing: Text('+${mission.points} pts'),
                      ),
                  ],
                ),
        ),
      ],
    );
  }

  String _initials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return 'EO';
    }
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      final word = parts.first;
      return word.substring(0, word.length >= 2 ? 2 : 1).toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
