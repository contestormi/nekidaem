part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationStart extends AuthenticationEvent {
  final String username;
  final String password;

  AuthenticationStart(this.username, this.password);
}
