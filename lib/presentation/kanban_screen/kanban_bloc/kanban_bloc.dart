import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nekidaem/data/models/card_model.dart';
import 'package:nekidaem/data/repository.dart';

part 'kanban_event.dart';
part 'kanban_state.dart';

class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  final Repository _repository = Repository();

  KanbanBloc() : super(KanbanInitial()) {
    on<KanbanStartLoading>(_onKanbanLoadingEvent);
    on<KanbanLogout>(_onKanbanLogoutEvent);
  }

  void _onKanbanLoadingEvent(
    KanbanStartLoading event,
    Emitter<KanbanState> emit,
  ) async {
    try {
      emit(KanbanLoading());
      final result = await _repository.getAllCards();

      emit(KanbanLoaded(result));
    } catch (e) {
      emit(KanbanError(e.toString()));
    }
  }

  void _onKanbanLogoutEvent(
    KanbanLogout event,
    Emitter<KanbanState> emit,
  ) async {
    _repository.logout();
  }
}
