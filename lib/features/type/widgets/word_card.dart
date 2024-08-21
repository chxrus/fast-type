import 'package:fast_type/repositories/sentence/models/word_model.dart';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.wordModel,
  });

  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (color, backgroundColor) = colorsFromModel(theme);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        wordModel.word,
        style: theme.textTheme.labelLarge?.copyWith(color: color),
      ),
    );
  }

  (Color, Color) colorsFromModel(ThemeData theme) {
    return switch (wordModel.status) {
      WordStatus.correct => (
          theme.colorScheme.primary,
          theme.colorScheme.primaryContainer,
        ),
      WordStatus.error => (
          theme.colorScheme.error,
          theme.colorScheme.errorContainer,
        ),
      WordStatus.active => (
          theme.colorScheme.onSurface,
          theme.colorScheme.surfaceContainer,
        ),
      _ => (
          theme.colorScheme.onSurface,
          theme.colorScheme.surface,
        )
    };
  }
}
