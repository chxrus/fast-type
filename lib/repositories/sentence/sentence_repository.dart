import 'dart:math';

import 'package:fast_type/repositories/sentence/i_sentence_repository.dart';
import 'package:fast_type/repositories/sentence/models/word_model.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final class SentenceRepository implements ISentenceRepository {
  @override
  Future<List<WordModel>> getSentenceWords() async {
    final sentence = await _getRandomSentence();
    try {
      final wordList = sentence.split(' ');
      final firstWordModel =
          WordModel(word: wordList.first, status: WordStatus.active);
      final wordModelList =
          wordList.skip(1).map((word) => WordModel(word: word)).toList();
      return [firstWordModel, ...wordModelList];
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      throw SentenceRepositoryException(
          "Error loading words. Try again later.");
    }
  }

  Future<String> _getRandomSentence() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<String> textList = [
      r"Excepteur laboris id esse exercitation consequat labore elit ex cillum mollit quis Lorem consequat.",
      r"Velit consectetur minim cupidatat minim occaecat ut exercitation laboris nisi non eu.",
      r"Non mollit exercitation duis aliqua sint non aliqua Lorem labore ea ipsum.",
      r"Aliquip occaecat enim labore ullamco adipisicing duis commodo enim.",
      r"Eiusmod ullamco esse voluptate do excepteur tempor ullamco ullamco officia pariatur laboris labore officia cupidatat.",
      r"Consequat laboris non ex quis. Velit fugiat cupidatat nulla ex deserunt ullamco est minim anim irure adipisicing non pariatur. Nostrud exercitation anim minim occaecat anim deserunt in et velit tempor id. Culpa pariatur sunt cillum tempor ut. Ad quis fugiat labore dolor deserunt. Enim in amet ex velit esse nostrud occaecat dolor cupidatat aute labore proident dolor. Nostrud in nisi quis duis eiusmod irure mollit ex et ullamco est.",
      r"Deserunt elit minim duis incididunt veniam dolor excepteur Lorem aute laboris ullamco incididunt ea. Dolor irure proident aliquip sunt officia. Tempor laborum deserunt amet dolore culpa. Minim et nostrud minim ex ipsum. Qui sit sunt cupidatat culpa sunt reprehenderit reprehenderit consequat. Dolore non aute esse sint qui dolore.",
      r"Duis anim minim est et. Qui veniam et reprehenderit consequat Lorem dolor ad nisi irure occaecat Lorem laboris in aliqua. Aliqua id irure irure dolore fugiat commodo elit reprehenderit sunt. Ex reprehenderit commodo laborum consectetur ad aliqua Lorem est in. Dolor non veniam nisi eiusmod sit culpa cillum. Do elit et id incididunt.",
      r"Eu proident mollit nisi pariatur irure ullamco pariatur anim ut ex Lorem deserunt. Et minim ea minim in consequat. Sit amet excepteur est amet. Deserunt minim quis pariatur cillum tempor voluptate labore. Proident cillum velit consectetur dolore occaecat incididunt. Dolor minim aliqua et in. Minim duis excepteur dolor do do commodo non labore.",
    ];
    final randomIndex = Random().nextInt(textList.length);

    return textList[randomIndex];
  }
}

class SentenceRepositoryException implements Exception {
  final String message;

  SentenceRepositoryException(this.message);
}
