import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/mock_data.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/section_panel.dart';
import '../../../shared/widgets/status_badge.dart';

/// Tela de apoio do Educador: visualização e gestão rápida das turmas.
/// Cada turma abre um detalhe com indicadores e educandos.
class EducadorTurmasView extends StatelessWidget {
  const EducadorTurmasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minhas turmas',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'Selecione uma turma para ver indicadores e a lista de educandos.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        SectionPanel(
          title: 'Turmas acompanhadas',
          subtitle: '${mockClasses.length} turmas na rede EurON.',
          child: Column(
            children: [
              for (final classSummary in mockClasses)
                ListTile(
                  leading: const Icon(Icons.class_outlined),
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
                      context.push('/educador/turma/${classSummary.id}'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
