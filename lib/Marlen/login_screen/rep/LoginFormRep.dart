import '../../../common/BaseApi.dart';
import '../api/LoginFormApi.dart';
import '../model/LoginUserDto.dart';

class LoginFormRep {
  final LoginFormApi _api = LoginFormApi();
// Внутри LoginFormRep
  Future<Response> deleteUser(int id) async {
    return _api.delete("api/users/$id/");
  }
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
