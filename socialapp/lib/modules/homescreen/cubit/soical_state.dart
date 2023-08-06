part of 'soical_cubit.dart';

@immutable
abstract class SoicalState {}

class SoicalInitial extends SoicalState {}

class SocialGetUserLoading extends SoicalState {}

class SocialGetUserSuccess extends SoicalState {}

class SocialGetUserError extends SoicalState {}
