import 'package:equatable/equatable.dart';

enum WordStatus {
  inactive,
  active,
  correct,
  error;
}

final class WordModel extends Equatable {
  final WordStatus status;
  final String word;

  const WordModel({
    this.status = WordStatus.inactive,
    required this.word,
  });

  WordModel copyWith({
    WordStatus? status,
    String? text,
  }) {
    return WordModel(
      status: status ?? this.status,
      word: text ?? word,
    );
  }

  @override
  String toString() => 'WordModel(status: $status, text: $word)';

  @override
  List<Object> get props => [word, status];
}
