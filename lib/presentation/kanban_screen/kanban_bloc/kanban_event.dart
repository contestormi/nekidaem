part of 'kanban_bloc.dart';

@immutable
abstract class KanbanEvent {}

class KanbanStartLoading extends KanbanEvent {}

class KanbanLogout extends KanbanEvent {}
