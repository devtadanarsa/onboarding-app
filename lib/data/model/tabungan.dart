class DataTabungan {
  final List<Tabungan> data;
  DataTabungan({required this.data});

  factory DataTabungan.fromJson(Map<String, dynamic> tabunganJson) =>
      DataTabungan(
        data: List.from(
          tabunganJson["data"]["tabungan"].map(
            (tabungan) => Tabungan.fromModel(tabungan),
          ),
        ),
        // saldo: saldoJson["data"]["saldo"],
      );
}

class Tabungan {
  final int id;
  final DateTime tanggal;
  final int idTransaksi;
  final int nominalTransaksi;

  Tabungan({
    required this.id,
    required this.tanggal,
    required this.idTransaksi,
    required this.nominalTransaksi,
  });

  factory Tabungan.fromModel(Map<String, dynamic> json) => Tabungan(
      id: json["data"]["tabungan"]["id"],
      tanggal: json["data"]["tabungan"]["trx_tanggal"],
      idTransaksi: json["data"]["tabungan"]["trx_id"],
      nominalTransaksi: json["data"]["tabungan"]["trx_nominal"]);
}
