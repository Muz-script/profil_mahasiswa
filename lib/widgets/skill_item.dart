import 'package:flutter/material.dart';

/// Item skill untuk ListView.
class SkillItem extends StatelessWidget {
  final String nama;

  const SkillItem({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: cs.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.secondary.withAlpha(60),
          child: Icon(Icons.record_voice_over_rounded, color: cs.primary),
        ),
        title: Text(
          nama,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        trailing: Icon(Icons.check_circle_rounded, color: cs.primary),
      ),
    );
  }
}
