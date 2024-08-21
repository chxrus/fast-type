import 'package:equatable/equatable.dart';
import 'package:fast_type/repositories/sentence/i_sentence_repository.dart';
import 'package:fast_type/repositories/sentence/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'type_screen_event.dart';
part 'type_screen_state.dart';

class TypeScreenBloc extends Bloc<TypeScreenEvent, TypeScreenState> {
  TypeScreenBloc({
    required ISentenceRepository sentenceRepository,
  })  : _sentenceRepository = sentenceRepository,
        super(const TypeScreenState(status: TypeScreenStatus.ended)) {
    on<TypeScreenLoadTypingTaskEvent>(_loadTypingTask);
    on<TypeScreenInputUpdateEvent>(_inputUpdate);
    on<TypeScreenInputCleanedEvent>(_inputCleaned);

    _currentWordIndex = 0;
  }

  final ISentenceRepository _sentenceRepository;
  late int _currentWordIndex;
  List<WordModel>? _wordModelList;

  void _loadTypingTask(TypeScreenLoadTypingTaskEvent event,
      Emitter<TypeScreenState> emit) async {
    try {
      emit(state.copyWith(status: TypeScreenStatus.loading));
      _wordModelList = await _sentenceRepository.getSentenceWords();
      emit(state.copyWith(
          status: TypeScreenStatus.loaded, wordModelList: _wordModelList!));
    } on Exception catch (e, st) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: TypeScreenStatus.loadingFailure,
        ),
      );
      GetIt.I<Talker>().handle(e, st);
    }
  }

  void _inputUpdate(
      TypeScreenInputUpdateEvent event, Emitter<TypeScreenState> emit) async {
    if (_wordModelList == null) return;

    final words = [..._wordModelList!];
    final input = event.inputText.trim();
    final current = words[_currentWordIndex].copyWith();
    final nextWordIndex = _currentWordIndex + 1;
    TypeScreenStatus? newScreenStatus;
    WordStatus? newWordStatus;
    bool? newNeedToCleanInput;

    bool isFailure =
        input.length > current.word.length || !current.word.startsWith(input);

    if (isFailure) {
      newWordStatus = WordStatus.error;
    } else {
      if (input == current.word) {
        newWordStatus = WordStatus.correct;
        newNeedToCleanInput = true;
      } else {
        newWordStatus = WordStatus.active;
      }
    }

    words[_currentWordIndex] = current.copyWith(status: newWordStatus);

    if (newWordStatus == WordStatus.correct && nextWordIndex == words.length) {
      _wordModelList = null;
      _currentWordIndex = 0;
      newScreenStatus = TypeScreenStatus.ended;
    } else if (newWordStatus == WordStatus.correct) {
      _currentWordIndex++;
      final next = words[nextWordIndex].copyWith();
      words[nextWordIndex] = next.copyWith(status: WordStatus.active);
    }

    _wordModelList = words;

    if (newScreenStatus == TypeScreenStatus.ended) {
      emit(
        state.copyWith(
          needToCleanInput: newNeedToCleanInput,
          status: TypeScreenStatus.loading,
          wordModelList: _wordModelList,
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
    }

    emit(
      state.copyWith(
        needToCleanInput: newNeedToCleanInput,
        status: newScreenStatus,
        wordModelList: _wordModelList,
      ),
    );
  }

  void _inputCleaned(
      TypeScreenInputCleanedEvent event, Emitter<TypeScreenState> emit) {
    emit(state.copyWith(needToCleanInput: false));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    GetIt.I<Talker>().handle(error, stackTrace);
    super.onError(error, stackTrace);
  }
}
