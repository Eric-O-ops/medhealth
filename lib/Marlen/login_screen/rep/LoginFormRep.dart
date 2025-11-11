import '../api/LoginFormApi.dart';
import '../model/LoginUserDto.dart';

class LoginFormRep {
  final LoginFormApi _api = LoginFormApi();

  Future<List<LoginUserDto>> getOwners() async {
    final response = await _api.fetchOwners();

    if (response.code == 200) {
      final List data = response.body; // список владельцев
      return data.map((e) => LoginUserDto.fromJson(e)).toList();
    } else {
      throw Exception("Ошибка при загрузке владельцев");
    }
  }
}
