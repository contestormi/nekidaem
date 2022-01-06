import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nekidaem/data/repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository _repository = Repository();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationStart>(_onAuthEvent);
  }

  void _onAuthEvent(
    AuthenticationStart event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await _repository.getJWTToken(
          password: event.password, username: event.username);
      emit(AuthenticationSucces());
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }
}
