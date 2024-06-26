part of 'member_bloc.dart';

@immutable
sealed class MemberState {}

final class MemberInitial extends MemberState {}

final class MemberLoading extends MemberState {}

final class MemberLoaded extends MemberState {
  final List<Member> members;
  MemberLoaded(this.members);
}

final class MemberError extends MemberState {
  final int errorCode;
  final String errorDescription;
  MemberError(this.errorCode, this.errorDescription);
}

final class MemberAdded extends MemberState {}

final class MemberEdited extends MemberState {}

final class MemberDeleted extends MemberState {}
