import 'package:dio/dio.dart' hide Response;
import '../../../../common/BaseApi.dart';

class OwnerRep {
  final BaseApi _api = BaseApi();
  int? _ownerId;

  void setOwnerId(int id) {
    _ownerId = id;
    print("OwnerRep настроен на owner_id: $_ownerId");
  }
  Future<Response> fetchBranches() async {
    if (_ownerId == null) return Response(code: 200, body: []);
    return _api.fetch("api/branches/?owner_id=$_ownerId");
  }

  Future<Response> createBranch(String address) async {
    final postData = {
      "address": address,
      "description": "Филиал",
      "clinic_owner_id": _ownerId,
      "working_hours": "09:00 - 18:00",
      "off_days": "Сб, Вс"
    };

    return await _api.post("api/branches/", postData);
  }

  Future<Response> updateBranch(int id, Map<String, dynamic> data) async {

    return await _api.patch("api/branches/$id/", data);
  }

  Future<Response> deleteBranch(int id) async {
    return await _api.delete("api/branches/$id/");
  }



  Future<Response> fetchManagers() async {
    if (_ownerId == null) return Response(code: 200, body: []);
    return _api.fetch("api/managers/?owner_id=$_ownerId");
  }

  Future<Response> createManager(Map<String, dynamic> data) async {
    return _api.post("api/managers/", data);
  }

  Future<Response> deleteManager(int userId) async {
    return await _api.delete("api/users/$userId/");
  }

  Future<Response> updateManager(int userId, Map<String, dynamic> data) async {
    return await _api.patch("api/users/$userId/", data);
  }
}