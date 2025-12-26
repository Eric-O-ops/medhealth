import 'package:dio/dio.dart' hide Response;
import '../../../../common/BaseApi.dart';

class ManagerRep {
  final BaseApi _api = BaseApi();

  // 1. Получить информацию о самом менеджере, чтобы узнать ID его филиала
  // Мы ищем менеджера по user_id (который мы получили при логине)
  Future<Response> getManagerInfo(int userId) async {
    // Фильтруем список менеджеров по user_id
    // Бэкенд должен поддерживать ?user_id=... или возвращать список, где мы найдем нужного
    return await _api.fetch("api/managers/?user=$userId");
  }

  // 2. Получить список врачей филиала
  Future<Response> getDoctors(int branchId) async {
    return await _api.fetch("api/doctors/?branch=$branchId");
  }

  // 3. Создать врача
  Future<Response> createDoctor(Map<String, dynamic> data) async {
    return await _api.post("api/doctors/", data);
  }

  // 4. Обновить врача
  Future<Response> updateDoctor(int id, Map<String, dynamic> data) async {
    return await _api.patch("api/doctors/$id/", data);
  }

  // 5. Удалить врача (удаляем пользователя)
  Future<Response> deleteDoctorUser(int userId) async {
    return await _api.delete("api/users/$userId/");
  }
}