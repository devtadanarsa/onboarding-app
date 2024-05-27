part of 'tabungan_bloc.dart';

@immutable
sealed class TabunganEvent {}

final class LoadTabungan extends TabunganEvent {
  final int memberId;
  LoadTabungan({required this.memberId});
}

final class TransaksiTabungan extends TabunganEvent {
  final int memberId;
  final int idTransaksi;
  final int nominal;

  TransaksiTabungan({
    required this.memberId,
    required this.idTransaksi,
    required this.nominal,
  });
}
