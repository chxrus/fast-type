import 'package:fast_type/features/type/widgets/widgets.dart';
import 'package:fast_type/repositories/sentence/models/word_model.dart';
import 'package:flutter/material.dart';

class TextWrapper extends StatelessWidget {
  const TextWrapper({
    super.key,
    required this.wordModelList,
  });

  final List<WordModel> wordModelList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: wordModelList
          .map((wordModel) => WordCard(wordModel: wordModel))
          .toList(),
    );
  }
}
