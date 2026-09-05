import 'package:flutter/material.dart';

import '../../models/dashboard_models.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    required this.title,
    required this.options,
    required this.selectedId,
    required this.onChanged,
    super.key,
  });

  final String title;
  final List<FilterOption> options;
  final String selectedId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Text(
            'Filtros indisponíveis no momento.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in options)
                  ChoiceChip(
                    label: Text(option.label),
                    selected: selectedId == option.id,
                    onSelected: (_) => onChanged(option.id),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
