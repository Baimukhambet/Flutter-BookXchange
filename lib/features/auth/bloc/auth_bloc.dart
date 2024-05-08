import 'package:bloc/bloc.dart';
import 'package:cubit_test/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService.shared;

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginTapped>(_onLogin);
    on<AuthRegisterTapped>(_onRegister);
    on<AuthRetryTapped>(
      (event, emit) => emit(AuthInitial()),
    );
  }

  void _onLogin(AuthLoginTapped event, Emitter emit) async {
    emit(AuthLoading());
    try {
      await authService.signInWithEmailAndPassword(event.email, event.password);
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void _onRegister(AuthRegisterTapped event, Emitter emit) async {
    emit(AuthLoading());
    try {
      if (event.password == event.repeatPassword &&
          event.password.length >= 6) {
        await authService.registerUserWithEmailAndPassword(
            event.email, event.password);
      } else {
        emit(AuthFailed('Password is insufficient'));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
