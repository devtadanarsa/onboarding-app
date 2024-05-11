import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/data/model/user.dart';

class RemoteDataSource {
  final dio = Dio(BaseOptions(baseUrl: "https://mobileapis.manpits.xyz/api"));
  final _localStorage = GetStorage();

  Future<User> getUser() async {
    final response = await dio.get(
      '/user',
      options: Options(
        headers: {
          "Authorization": "Bearer ${_localStorage.read("token")}",
        },
      ),
    );

    return User.fromModel(response.data);
  }

  Future<DataMember> getMembers() async {
    final response = await dio.get(
      "/anggota",
      options: Options(
        headers: {"Authorization": "Bearer ${_localStorage.read("token")}"},
      ),
    );

    return DataMember.fromJson(response.data);
  }

  Future addMember(Member member) async {
    final response = await dio.post(
      "/anggota",
      data: {
        "nomor_induk": member.nomorInduk,
        "nama": member.name,
        "alamat": member.address,
        "tgl_lahir": member.dateOfBirth,
        "telepon": member.phoneNumber,
      },
      options: Options(
        headers: {"Authorization": "Bearer ${_localStorage.read("token")}"},
      ),
    );

    return response;
  }

  Future deleteMember(int memberId) async {
    final response = await dio.delete(
      "/anggota/$memberId",
      options: Options(
        headers: {"Authorization": "Bearer ${_localStorage.read("token")}"},
      ),
    );

    return response;
  }

  Future editMember(Member member) async {
    final response = await dio.put(
      "/anggota/${member.id}",
      data: {
        "nomor_induk": member.nomorInduk,
        "nama": member.name,
        "alamat": member.address,
        "tgl_lahir": member.dateOfBirth,
        "telepon": member.phoneNumber,
        "status_aktif": member.isActive,
      },
      options: Options(
        headers: {"Authorization": "Bearer ${_localStorage.read("token")}"},
      ),
    );

    return response;
  }
}
