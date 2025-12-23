import 'package:medhealth/common/BaseApi.dart';

class ApplicationFormApi extends BaseApi {

  Future<Response> fetchApplicationForm() async {
    return fetch("requests/");
  }

  Future<Response> sentApplicationFrom(Map<String, dynamic> postData) async {
    return post("requests/", postData);
  }
// ⭐️ ДОБАВЛЕНО: Метод для удаления заявки
  Future<Response> deleteApplicationForm(int requestId) async {
    return delete("requests/$requestId/");
  }
}