import 'package:medhealth/common/BaseApi.dart';

class LoginFormApi extends BaseApi {
  Future<Response> fetchOwners() async {
    return fetch("api/owners/"); // ← делает HTTP GET запрос
  }
}
