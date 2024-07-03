part of 'bunga_bloc.dart';

@immutable
sealed class BungaEvent {}

final class LoadBunga extends BungaEvent {}

final class AddBunga extends BungaEvent {
  final Bunga bunga;

  AddBunga({required this.bunga});
}
