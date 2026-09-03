import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Um ponto do gráfico de barras.
class BarDatum {
  const BarDatum({required this.label, required this.value, this.status = 'info'});

  final String label;
  final double value;

  /// Chave de cor: success, info, attention, critical, neutral.
  final String status;
}

/// Gráfico de barras vertical reutilizável, construído apenas com widgets
/// básicos do Flutter (sem dependência de pacotes de gráficos).
///
/// Cada barra tem a altura proporcional ao seu valor (em relação a [maxY]) e
/// usa a paleta de status do tema para a cor.
class SimpleBarChart extends StatelessWidget {
  const SimpleBarChart({
    required this.data,
    this.maxY = 100,
    this.height = 240,
    super.key,
  });

  final List<BarDatum> data;
  final double maxY;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text('Sem dados para exibir.', style: theme.textTheme.bodySmall),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final datum in data)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    // Área da barra: cresce para ocupar o espaço disponível e
                    // a barra é ancorada na base com altura proporcional.
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: (datum.value / maxY).clamp(0.0, 1.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: _statusColor(context, datum.status),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      datum.label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      datum.value.toStringAsFixed(0),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _statusColor(BuildContext context, String status) {
    final statusColors = Theme.of(context).extension<EuroOneStatusColors>();
    return statusColors?.forStatus(status) ?? Colors.blueGrey;
  }
}
