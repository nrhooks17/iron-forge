import 'package:flutter/material.dart';

class MotivationalHeader extends StatelessWidget {
  final List<String> quotes;
  final String? subtitle;

  const MotivationalHeader({
    super.key,
    required this.quotes,
    this.subtitle,
  });

  static const List<String> defaultQuotes = [
    "FORGE YOUR STRENGTH",
    "PAIN IS TEMPORARY, VICTORY IS ETERNAL", 
    "SWEAT TODAY, SHINE TOMORROW",
    "NO EXCUSES, ONLY RESULTS",
    "PUSH YOUR LIMITS",
  ];

  @override
  Widget build(BuildContext context) {
    final quotesToUse = quotes.isNotEmpty ? quotes : defaultQuotes;
    final quote = quotesToUse[DateTime.now().day % quotesToUse.length];
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}