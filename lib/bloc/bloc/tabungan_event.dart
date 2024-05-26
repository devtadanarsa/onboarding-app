part of 'tabungan_bloc.dart';

@immutable
sealed class TabunganEvent {}

final class LoadTabungan extends TabunganEvent {
  final int memberId;
  LoadTabungan({required this.memberId});
}
