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
      );
}

class Tabungan {
  final int id;
  final String tanggal;
  final int idTransaksi;
  final int nominalTransaksi;

  Tabungan({
    required this.id,
    required this.tanggal,
    required this.idTransaksi,
    required this.nominalTransaksi,
  });

  factory Tabungan.fromModel(Map<String, dynamic> json) => Tabungan(
      id: json["id"],
      tanggal: json["trx_tanggal"],
      idTransaksi: json["trx_id"],
      nominalTransaksi: json["trx_nominal"]);
}
