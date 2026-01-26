
import 'package:medhealth/common/BaseApi.dart';

class AdminRep {
  final BaseApi _api = BaseApi();

  Future<Response> registerOwnerAndAddClinic(Map<String, dynamic> postData) async {
    return _api.post("api/owners/", postData);
  }
  Future<Response> manualCreateClinic(Map<String, dynamic> data) async {
    return _api.post("api/owners/", data);
  }
}