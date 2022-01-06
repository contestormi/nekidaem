part of 'kanban_bloc.dart';

@immutable
abstract class KanbanState {}

class KanbanInitial extends KanbanState {}

class KanbanError extends KanbanState {
  final String error;

  KanbanError(this.error);
}

class KanbanLoading extends KanbanState {}

class KanbanLoaded extends KanbanState {
  final List<CardModel> listOfCards;

  KanbanLoaded(this.listOfCards);
}
