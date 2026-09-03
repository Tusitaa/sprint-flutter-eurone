import 'package:flutter/material.dart';

/// Poses/expressões disponíveis do mascote Euri (arte oficial, fundo
/// transparente). Cada valor aponta para um asset em `assets/images/`.
enum EuriPose {
  /// Acenando — padrão amigável para avatares e cabeçalhos.
  acenando('assets/images/euri-acenando.png'),

  /// Comemorando (braços erguidos) — telas de destaque.
  comemorando('assets/images/euri-comemorando.png'),

  /// Apresentando um painel — contextos de dados e indicadores.
  apresentando('assets/images/euri-apresentando.png'),

  /// Anotando em uma prancheta — contextos de acompanhamento.
  anotando('assets/images/euri-anotando.png'),

  /// Curioso, com lupa — contextos de exploração e busca.
  curioso('assets/images/euri-curioso.png');

  const EuriPose(this.asset);

  final String asset;
}

/// Mascote visual do EuroONE, a "Euri".
///
/// Componente decorativo: exibe a arte oficial do mascote na [pose] indicada,
/// em um tamanho consistente. Não possui lógica, estado ou interação.
class EuriMascot extends StatelessWidget {
  const EuriMascot({super.key, this.size = 40, this.pose = EuriPose.acenando});

  /// Tamanho (largura e altura) da arte.
  final double size;

  /// Pose/expressão exibida.
  final EuriPose pose;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      pose.asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: 'Euri, mascote do EuroONE',
    );
  }
}

/// Faixa de destaque contextual com a Euri e uma mensagem curta.
///
/// Reutilizada no topo das telas principais para dar identidade e um toque
/// de boas-vindas coerente com o contexto de cada persona.
class EuriHint extends StatelessWidget {
  const EuriHint({
    super.key,
    required this.pose,
    required this.message,
    this.mascotSize = 52,
  });

  final EuriPose pose;
  final String message;
  final double mascotSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            EuriMascot(pose: pose, size: mascotSize),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
