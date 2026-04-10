import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Temple_App/services/auth_service.dart';

abstract class AuthEvent {}


class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  SignupEvent(this.email, this.password);
}


class ResetEvent extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {}     // ✅ login only

class SignupSuccess extends AuthState {}    // ✅ signup only

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {


    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await authService.login(event.email, event.password);
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthError(e.message ?? "Login failed"));
      } catch (e) {
        emit(AuthError("Something went wrong"));
      }
    });


    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await authService.signup(event.email, event.password);
        emit(SignupSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthError(e.message ?? "Signup failed"));
      } catch (e) {
        emit(AuthError("Something went wrong"));
      }
    });


    on<ResetEvent>((event, emit) {
      emit(AuthInitial());
    });
  }
}