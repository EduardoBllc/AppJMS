import 'package:flutter/material.dart';

class BorderedMaterialButton extends StatelessWidget {
  const BorderedMaterialButton({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
    this.textStyle,
  });

  final Color color;
  final String text;
  final TextStyle? textStyle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      onPressed: onTap,
      elevation: 1,
      color: color.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.white.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class RoundedMaterialButton extends StatelessWidget {
  const RoundedMaterialButton({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.elevation,
  });

  final Color color;
  final String text;
  final TextStyle? textStyle;
  final void Function() onTap;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      onPressed: onTap,
      elevation: elevation ?? 1,
      color: color.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
