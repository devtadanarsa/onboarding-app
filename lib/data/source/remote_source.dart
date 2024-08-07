import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding_app/data/model/bunga.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/data/model/tabungan.dart';
import 'package:onboarding_app/data/model/user.dart';

class RemoteDataSource {
  final Dio _dio;
  final GetStorage _localStorage;

  RemoteDataSource()
      : _dio = Dio(BaseOptions(baseUrl: "https://mobileapis.manpits.xyz/api")),
        _localStorage = GetStorage();

  Options _getOptions() {
    return Options(
      headers: {
        "Authorization": "Bearer ${_localStorage.read("token")}",
      },
    );
  }

  Future<User> getUser() async {
    final response = await _dio.get('/user', options: _getOptions());
    return User.fromModel(response.data);
  }

  Future<DataMember> getMembers() async {
    final response = await _dio.get("/anggota", options: _getOptions());
    return DataMember.fromJson(response.data);
  }

  Future addMember(Member member) async {
    final response = await _dio.post(
      "/anggota",
      data: {
        "nomor_induk": member.nomorInduk,
        "nama": member.name,
        "alamat": member.address,
        "tgl_lahir": member.dateOfBirth,
        "telepon": member.phoneNumber,
      },
      options: _getOptions(),
    );

    return response;
  }

  Future deleteMember(int memberId) async {
    final response =
        await _dio.delete("/anggota/$memberId", options: _getOptions());
    return response;
  }

  Future editMember(Member member) async {
    final response = await _dio.put(
      "/anggota/${member.id}",
      data: {
        "nomor_induk": member.nomorInduk,
        "nama": member.name,
        "alamat": member.address,
        "tgl_lahir": member.dateOfBirth,
        "telepon": member.phoneNumber,
        "status_aktif": member.isActive,
      },
      options: _getOptions(),
    );

    return response;
  }

  Future getTabungan(int memberId) async {
    final response = await _dio.get(
      "/tabungan/$memberId",
      options: _getOptions(),
    );

    return DataTabungan.fromJson(response.data);
  }

  Future getSaldo(int memberId) async {
    final response = await _dio.get(
      "/saldo/$memberId",
      options: _getOptions(),
    );
    return response.data;
  }

  Future transaksiTabungan(int memberId, int idTransaksi, int nominal) async {
    final response = await _dio.post(
      "/tabungan",
      data: {
        "anggota_id": memberId,
        "trx_id": idTransaksi,
        "trx_nominal": nominal,
      },
      options: _getOptions(),
    );

    return response;
  }

  Future getBunga() async {
    final response = await _dio.get("/settingbunga", options: _getOptions());
    if (response.data["data"]["activebunga"] == null) {
      return null;
    }
    return DataBunga.fromJson(response.data);
  }

  Future addBunga(Bunga bunga) async {
    final response = await _dio.post(
      "/addsettingbunga",
      data: {
        "persen": bunga.persen,
        "isaktif": bunga.isActive,
      },
      options: _getOptions(),
    );

    return response;
  }
}
