import '../api/LoginFormApi.dart';
import '../model/LoginUserDto.dart';

class LoginFormRep {
  final LoginFormApi _api = LoginFormApi();

  Future<List<LoginUserDto>> getUsers() async {
    final response = await _api.fetchUsers();

    if (response.code == 200) {
      final List data = response.body;
      return data.map((e) => LoginUserDto.fromJson(e)).toList();
    } else {
      throw Exception("Ошибка при загрузке пользователей");
    }
  }
}
