import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = kColorScheme;

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.primary,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.primaryContainer,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.secondary,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.secondaryContainer,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.tertiary,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.tertiaryContainer,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.background,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.surface,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: colorScheme.error,
                ),
              ),
              Expanded(
                child: Container(
                  color: colorScheme.onError,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
