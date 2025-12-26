import 'package:dio/dio.dart' hide Response; // Или ваш BaseApi import
import '../../../../common/BaseApi.dart'; // Убедитесь, что импорт верный

class OwnerRep {
  final BaseApi _api = BaseApi();
  int? _ownerId;

  void setOwnerId(int id) {
    _ownerId = id;
    print("OwnerRep настроен на owner_id: $_ownerId");
  }

  // --- ФИЛИАЛЫ ---

  Future<Response> fetchBranches() async {
    if (_ownerId == null) return Response(code: 200, body: []);
    // GET запрос списка требует owner_id
    return _api.fetch("api/branches/?owner_id=$_ownerId");
  }

  Future<Response> createBranch(String address) async {
    final postData = {
      "address": address,
      "description": "Филиал",
      "clinic_owner_id": _ownerId, // Важно: clinic_owner_id
      "working_hours": "09:00 - 18:00",
      "off_days": "Сб, Вс"
    };
    // POST api/branches/
    return await _api.post("api/branches/", postData);
  }

  Future<Response> updateBranch(int id, Map<String, dynamic> data) async {
    // PATCH api/branches/10/ (Слэш в конце обязателен!)
    // Больше не нужно передавать ?owner_id=... благодаря фиксу на бэке
    return await _api.patch("api/branches/$id/", data);
  }

  Future<Response> deleteBranch(int id) async {
    // DELETE api/branches/10/
    return await _api.delete("api/branches/$id/");
  }

  // --- МЕНЕДЖЕРЫ ---

  Future<Response> fetchManagers() async {
    if (_ownerId == null) return Response(code: 200, body: []);
    // Правильный URL согласно вашему urls.py
    return _api.fetch("api/managers/?owner_id=$_ownerId");
  }

  Future<Response> createManager(Map<String, dynamic> data) async {
    // URL должен быть api/managers/ а не api/clinic_owners/managers/
    return _api.post("api/managers/", data);
  }

  Future<Response> deleteManager(int userId) async {
    // Удаляем через api/users/ID/ так как Manager связан OneToOne с User
    // Или, если хотите удалять именно запись менеджера: api/managers/ID/
    // Но судя по коду модели вы хотите удалить User.
    return await _api.delete("api/users/$userId/");
  }

  // Метод для обновления менеджера
  Future<Response> updateManager(int userId, Map<String, dynamic> data) async {
    return await _api.patch("api/users/$userId/", data);
  }
}