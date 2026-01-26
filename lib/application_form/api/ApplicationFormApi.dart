import 'package:medhealth/common/BaseApi.dart';

class ApplicationFormApi extends BaseApi {

  Future<Response> fetchApplicationForm() async {
    return fetch("api/requests/");
  }

  Future<Response> sentApplicationFrom(Map<String, dynamic> postData) async {
    return post("api/requests/", postData);
  }
  Future<Response> deleteApplicationForm(int requestId) async {
    return delete("api/requests/$requestId/");
  }
}