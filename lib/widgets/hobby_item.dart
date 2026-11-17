import 'package:flutter/material.dart';

/// Item hobi untuk GridView.
class HobbyItem extends StatelessWidget {
  final String nama;

  const HobbyItem({super.key, required this.nama});

  IconData get _icon {
    final n = nama.toLowerCase();
    if (n.contains('sepeda')) return Icons.directions_bike_rounded;
    if (n.contains('touring')) return Icons.explore_rounded;
    return Icons.favorite_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary.withAlpha(40), cs.secondary.withAlpha(50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_icon, size: 34, color: cs.primary),
          const SizedBox(height: 8),
          Text(
            nama,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
