class DataBunga {
  final List<Bunga> listBunga;
  final Bunga activeBunga;
  DataBunga({required this.listBunga, required this.activeBunga});

  factory DataBunga.fromJson(Map<String, dynamic> json) => DataBunga(
      listBunga: List.from(
        json["data"]["settingbungas"].map(
          (bunga) => Bunga.fromModel(bunga),
        ),
      ),
      activeBunga: Bunga.fromModel(json["data"]["activebunga"]));
}

class Bunga {
  final int? id;
  final double persen;
  final int isActive;

  Bunga({
    this.id,
    required this.persen,
    required this.isActive,
  });

  factory Bunga.fromModel(Map<String, dynamic> json) => Bunga(
      id: json["id"],
      persen: (json["persen"] as num).toDouble(),
      isActive: json["isaktif"]);
}
