part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SendCodeEvent extends AuthEvent {
  SendCodeEvent({required this.phone});

  final String phone;
}

final class LoginEvent extends AuthEvent {
  LoginEvent({
    required this.phone,
    required this.code,
  });

  final String phone;
  final String code;
}
