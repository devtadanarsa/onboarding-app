import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
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
}
