import 'package:medhealth/common/BaseApi.dart';

class LoginFormApi extends BaseApi {
  Future<Response> fetchUsers() async {
    return fetch("api/users/"); // ← теперь запрашиваем всех пользователей
  }
}
