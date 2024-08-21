// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'type_screen_bloc.dart';

sealed class TypeScreenEvent extends Equatable {
  const TypeScreenEvent();

  @override
  List<Object> get props => [];
}

class TypeScreenLoadTypingTaskEvent extends TypeScreenEvent {
  @override
  List<Object> get props => [];
}

class TypeScreenInputUpdateEvent extends TypeScreenEvent {
  const TypeScreenInputUpdateEvent({
    required this.inputText,
  });

  final String inputText;

  @override
  List<Object> get props => [inputText];
}

class TypeScreenInputCleanedEvent extends TypeScreenEvent {}
