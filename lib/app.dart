import 'package:fast_type/features/type/type.dart';
import 'package:fast_type/repositories/sentence/sentence.dart';
import 'package:fast_type/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ISentenceRepository>(
      create: (context) => SentenceRepository(),
      child: MaterialApp(
        title: 'Fast Type',
        theme: darkTheme,
        home: const TypeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
