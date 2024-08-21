import 'package:fast_type/features/type/bloc/bloc/type_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: () => context.read<TypeScreenBloc>().add(
            TypeScreenLoadTypingTaskEvent(),
          ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'S T A R T',
          style: theme.textTheme.displayLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
