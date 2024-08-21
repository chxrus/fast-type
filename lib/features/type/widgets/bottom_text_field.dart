import 'package:fast_type/features/type/bloc/bloc/type_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTextField extends StatefulWidget {
  const BottomTextField({
    super.key,
  });

  @override
  State<BottomTextField> createState() => _BottomTextFieldState();
}

class _BottomTextFieldState extends State<BottomTextField> {
  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<TypeScreenBloc, TypeScreenState>(
      listener: (context, state) {
        if (state.needToCleanInput) {
          _controller.clear();
          context.read<TypeScreenBloc>().add(TypeScreenInputCleanedEvent());
        }
      },
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: _controller,
          onChanged: (inputText) => context
              .read<TypeScreenBloc>()
              .add(TypeScreenInputUpdateEvent(inputText: inputText)),
          autofocus: true,
          focusNode: _focusNode,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: theme.colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface,
                width: .5,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ),
    );
  }
}
