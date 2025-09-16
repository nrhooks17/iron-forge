import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final BorderRadius? borderRadius;

  const GradientProgressBar({
    super.key,
    required this.value,
    this.height = 8,
    this.backgroundColor,
    this.gradientColors,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(height / 2);
    final bgColor = backgroundColor ?? 
        Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);
    final colors = gradientColors ?? [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
    ];

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: bgColor,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(colors: colors),
          ),
        ),
      ),
    );
  }
}