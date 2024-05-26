part of 'tabungan_bloc.dart';

@immutable
sealed class TabunganState {}

final class TabunganInitial extends TabunganState {}

final class TabunganLoading extends TabunganState {}

final class TabunganLoaded extends TabunganState {
  final int saldo;
  final List<Tabungan> tabungan;
  TabunganLoaded(this.tabungan, this.saldo);
}

final class TabunganError extends TabunganState {
  final int errorCode;
  final String errorDescription;
  TabunganError(this.errorCode, this.errorDescription);
}
