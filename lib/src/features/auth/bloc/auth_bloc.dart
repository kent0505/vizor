import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../data/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        SendCodeEvent() => _sendCodeEvent(event, emit),
        LoginEvent() => _loginEvent(event, emit),
        LogoutEvent() => _logoutEvent(event, emit),
      },
    );
  }

  void _sendCodeEvent(
    SendCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _repository.sendCode(event.phone);
      emit(CodeSent());
    } catch (e) {
      logger(e);
      emit(AuthError(error: e.toString()));
    }
  }

  void _loginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _repository.login(
        event.phone,
        event.code,
      );
      emit(Logined());
    } catch (e) {
      logger(e);
      emit(AuthError(error: e.toString()));
    }
  }

  void _logoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout();
    emit(AuthInitial());
  }
}
