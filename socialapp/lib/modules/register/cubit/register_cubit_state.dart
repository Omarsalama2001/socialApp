part of 'register_cubit_cubit.dart';

@immutable
abstract class RegisterCubitState {}

class RegisterCubitInitial extends RegisterCubitState {}

class ChangeObsecure extends RegisterCubitState {}

class RegisterLoadingState extends RegisterCubitState {}

class RegisterSuccessState extends RegisterCubitState {}

class RegisterErrorState extends RegisterCubitState {
  String? error;
  RegisterErrorState(
    this.error,
  );
}

class CreateUserLoading extends RegisterCubitState {}

class CreateUserSuccess extends RegisterCubitState {}

class CreateUserError extends RegisterCubitState {
  String? error;
  CreateUserError(this.error);
}
