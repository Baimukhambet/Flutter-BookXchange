part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginTapped extends AuthEvent {
  final String email;
  final String password;

  AuthLoginTapped({required this.email, required this.password});
}

final class AuthRegisterTapped extends AuthEvent {
  final String email;
  final String password;
  final String repeatPassword;

  AuthRegisterTapped(
      {required this.email,
      required this.password,
      required this.repeatPassword});
}

final class AuthRetryTapped extends AuthEvent {}
