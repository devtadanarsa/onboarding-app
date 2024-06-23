part of 'bunga_bloc.dart';

@immutable
sealed class BungaState {}

final class BungaInitial extends BungaState {}

final class BungaLoading extends BungaState {}

final class BungaLoaded extends BungaState {
  final List<Bunga> listBunga;
  final Bunga activeBunga;

  BungaLoaded(this.listBunga, this.activeBunga);
}

final class BungaError extends BungaState {
  final String error;
  BungaError(this.error);
}
