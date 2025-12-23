// ApplicationFormRep.dart (Обновленный)
import 'package:medhealth/application_form/api/ApplicationFormApi.dart';
import '../../common/BaseApi.dart';

class ApplicationFormRep {
  final ApplicationFormApi _api = ApplicationFormApi();

  Future<Response> postApplicationForm(Map<String, dynamic> postData) async {
    return _api.sentApplicationFrom(postData);
  }

  // ➡️ ДОБАВЛЕННЫЙ МЕТОД ДЛЯ ПОЛУЧЕНИЯ СПИСКА ЗАЯВОК
  Future<Response> fetchApplicationForm() async {
    // Вызов соответствующего метода из API
    return _api.fetchApplicationForm();
  }
  // ⭐️ ДОБАВЛЕНО: Метод для отклонения (удаления) заявки
  Future<Response> rejectApplicationForm(int requestId) async {
    return _api.deleteApplicationForm(requestId);
  }
}