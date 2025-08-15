part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class CodeSent extends AuthState {}

final class Logined extends AuthState {}

final class AuthError extends AuthState {
  AuthError({required this.error});

  final String error;
}
