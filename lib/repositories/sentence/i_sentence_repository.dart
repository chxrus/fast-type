import 'package:fast_type/repositories/sentence/models/models.dart';

abstract interface class ISentenceRepository {
  Future<List<WordModel>> getSentenceWords();
}
