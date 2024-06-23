part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class ExpiredToken extends UserState {}

final class UserLoaded extends UserState {
  final User userInformation;
  UserLoaded(this.userInformation);
}

final class UserError extends UserState {
  final String error;
  UserError(this.error);
}
