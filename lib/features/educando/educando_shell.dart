import 'package:flutter/material.dart';

import '../../shared/widgets/app_shell.dart';
import 'cursos/educando_cursos_view.dart';
import 'perfil/educando_perfil_view.dart';

/// Área do Educando com navegação entre as duas telas principais:
/// Perfil e Cursos e Fóruns.
class EducandoShell extends StatefulWidget {
  const EducandoShell({super.key});

  @override
  State<EducandoShell> createState() => _EducandoShellState();
}

class _EducandoShellState extends State<EducandoShell> {
  int _index = 0;

  static const _titles = ['EuroONE | Perfil', 'EuroONE | Cursos e Fóruns'];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: _titles[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Cursos e Fóruns',
          ),
        ],
      ),
      child: IndexedStack(
        index: _index,
        children: const [EducandoPerfilView(), EducandoCursosView()],
      ),
    );
  }
}