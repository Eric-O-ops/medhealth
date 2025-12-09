import 'package:medhealth/common/BaseApi.dart';

class RecoveryPasswordApi extends BaseApi {

  Future<Response> fetchUsers(String email) {
    return fetch("api/users/");
  }

  Future<Response> changePassword(String id, String password) {
    return patch("api/users/$id/", {"password_user": password});
  }
}
