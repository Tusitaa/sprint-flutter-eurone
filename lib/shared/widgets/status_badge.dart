import 'package:flutter/material.dart';

import '../../app/theme.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.label, required this.status, super.key});

  final String label;
  final String status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(context, status);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.36)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
        ),
      ),
    );
  }

  static Color _statusColor(BuildContext context, String rawStatus) {
    final statusColors = Theme.of(context).extension<EuroOneStatusColors>();
    return statusColors?.forStatus(rawStatus) ?? Colors.blueGrey;
  }
}
