part of 'type_screen_bloc.dart';

enum TypeScreenStatus {
  loading,
  loadingFailure,
  loaded,
  started,
  inProcess,
  ended,
}

final class TypeScreenState extends Equatable {
  const TypeScreenState({
    required this.status,
    this.wordModelList,
    this.errorMessage,
    this.needToCleanInput = false,
  });

  final TypeScreenStatus status;
  final List<WordModel>? wordModelList;
  final String? errorMessage;
  final bool needToCleanInput;

  TypeScreenState copyWith({
    TypeScreenStatus? status,
    List<WordModel>? wordModelList,
    String? errorMessage,
    bool? needToCleanInput,
  }) {
    return TypeScreenState(
      status: status ?? this.status,
      wordModelList: wordModelList ?? this.wordModelList,
      errorMessage: errorMessage ?? this.errorMessage,
      needToCleanInput: needToCleanInput ?? this.needToCleanInput,
    );
  }

  @override
  List<Object?> get props =>
      [status, wordModelList, errorMessage, needToCleanInput];
}
