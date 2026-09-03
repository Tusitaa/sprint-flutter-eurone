import 'package:flutter/material.dart';

import '../../shared/widgets/app_shell.dart';
import 'professores/gestao_professores_view.dart';
import 'visao/gestao_visao_view.dart';

/// Área da Gestão com navegação entre o painel de professores e a visão geral
/// de alunos e métricas do sistema.
class GestaoShell extends StatefulWidget {
  const GestaoShell({super.key});

  @override
  State<GestaoShell> createState() => _GestaoShellState();
}

class _GestaoShellState extends State<GestaoShell> {
  int _index = 0;

  static const _titles = ['EuroONE | Professores', 'EuroONE | Visão geral'];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: _titles[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge),
            label: 'Professores',
          ),
          NavigationDestination(
            icon: Icon(Icons.query_stats_outlined),
            selectedIcon: Icon(Icons.query_stats),
            label: 'Visão geral',
          ),
        ],
      ),
      child: IndexedStack(
        index: _index,
        children: const [GestaoProfessoresView(), GestaoVisaoView()],
      ),
    );
  }
}