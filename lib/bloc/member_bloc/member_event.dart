part of 'member_bloc.dart';

@immutable
sealed class MemberEvent {}

final class LoadMember extends MemberEvent {}

final class AddMember extends MemberEvent {
  final Member member;

  AddMember({required this.member});
}
