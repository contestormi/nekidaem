part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError(this.error);
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSucces extends AuthenticationState {}
