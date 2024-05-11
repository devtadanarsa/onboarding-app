class DataMember {
  final List<Member> data;
  DataMember({required this.data});

  factory DataMember.fromJson(Map<String, dynamic> json) => DataMember(
        data: List.from(
          json["data"]["anggotas"].map(
            (member) => Member.fromModel(member),
          ),
        ),
      );
}

class Member {
  final int? id;
  final int nomorInduk;
  final String name;
  final String address;
  final String dateOfBirth;
  final String phoneNumber;
  final String? imageUrl;
  final int? isActive;

  Member({
    this.id,
    required this.nomorInduk,
    required this.name,
    required this.address,
    required this.dateOfBirth,
    required this.phoneNumber,
    this.imageUrl,
    this.isActive,
  });

  factory Member.fromModel(Map<String, dynamic> json) => Member(
      id: json["id"],
      nomorInduk: json["nomor_induk"],
      name: json["nama"],
      address: json["alamat"],
      dateOfBirth: json["tgl_lahir"],
      phoneNumber: json["telepon"],
      imageUrl: json["imageUrl"],
      isActive: json["id"]);
}
