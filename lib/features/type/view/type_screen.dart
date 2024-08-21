import 'package:fast_type/features/type/bloc/bloc/type_screen_bloc.dart';
import 'package:fast_type/features/type/widgets/widgets.dart';
import 'package:fast_type/repositories/sentence/i_sentence_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.25;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: BlocProvider(
        create: (context) => TypeScreenBloc(
          sentenceRepository: context.read<ISentenceRepository>(),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Header(),
                BlocBuilder<TypeScreenBloc, TypeScreenState>(
                  builder: (context, state) {
                    if (state.status == TypeScreenStatus.ended) {
                      return const StartButton();
                    }

                    if (state.status == TypeScreenStatus.loaded &&
                        state.wordModelList != null) {
                      return TextWrapper(
                        wordModelList: state.wordModelList!,
                      );
                    }

                    if (state.status == TypeScreenStatus.loading) {
                      return const CircularProgressIndicator(
                        strokeWidth: 4,
                      );
                    }

                    if (state.status == TypeScreenStatus.loadingFailure) {
                      return Text(
                        state.errorMessage!,
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      );
                    }

                    return Text(
                      'Loading error. Please try again later.',
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    );
                  },
                ),
                const BottomTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
