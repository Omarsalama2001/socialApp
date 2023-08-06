part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangeOscecure extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSucessState extends LoginState {
  String? userId;
  LoginSucessState(this.userId);
}

class LoginErrorState extends LoginState {
  String? error;
  LoginErrorState(this.error);
}
