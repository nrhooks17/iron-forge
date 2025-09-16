import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 48,
    this.padding,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final button = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: onPressed != null ? LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ) : null,
        color: onPressed == null ? Theme.of(context).colorScheme.surfaceContainer : null,
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: onPressed != null ? [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
        label: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            color: onPressed != null 
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
        ),
      ),
    );

    return icon != null && text.isNotEmpty ? button : 
           icon != null ? 
           Container(
             width: height,
             height: height,
             decoration: BoxDecoration(
               gradient: onPressed != null ? LinearGradient(
                 colors: [
                   Theme.of(context).colorScheme.primary,
                   Theme.of(context).colorScheme.secondary,
                 ],
               ) : null,
               color: onPressed == null ? Theme.of(context).colorScheme.surfaceContainer : null,
               borderRadius: BorderRadius.circular(height / 2),
               boxShadow: onPressed != null ? [
                 BoxShadow(
                   color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                   blurRadius: 8,
                   offset: const Offset(0, 4),
                 ),
               ] : null,
             ),
             child: IconButton(
               onPressed: onPressed,
               icon: Icon(
                 icon,
                 color: onPressed != null 
                     ? Theme.of(context).colorScheme.onPrimary
                     : Theme.of(context).colorScheme.outline,
               ),
             ),
           ) : button;
  }
}