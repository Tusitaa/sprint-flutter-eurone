import 'package:flutter/material.dart';

import '../../shared/widgets/app_shell.dart';
import 'desempenho/educador_desempenho_view.dart';
import 'turmas/educador_turmas_view.dart';

/// Área do Educador com navegação entre desempenho da turma e gestão das turmas.
class EducadorShell extends StatefulWidget {
  const EducadorShell({super.key});

  @override
  State<EducadorShell> createState() => _EducadorShellState();
}

class _EducadorShellState extends State<EducadorShell> {
  int _index = 0;

  static const _titles = ['EuroONE | Desempenho', 'EuroONE | Turmas'];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: _titles[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Desempenho',
          ),
          NavigationDestination(
            icon: Icon(Icons.class_outlined),
            selectedIcon: Icon(Icons.class_),
            label: 'Turmas',
          ),
        ],
      ),
      child: IndexedStack(
        index: _index,
        children: const [EducadorDesempenhoView(), EducadorTurmasView()],
      ),
    );
  }
}
