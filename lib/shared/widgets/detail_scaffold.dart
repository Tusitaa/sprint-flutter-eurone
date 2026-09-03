import 'package:flutter/material.dart';

/// Chrome padrão das telas de detalhe abertas a partir de uma listagem.
///
/// Fornece uma AppBar com botão de voltar automático e um corpo rolável
/// centralizado, mantendo a consistência visual com o restante do app.
class DetailScaffold extends StatelessWidget {
  const DetailScaffold({
    required this.title,
    required this.child,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            if (subtitle != null)
              Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [child],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
