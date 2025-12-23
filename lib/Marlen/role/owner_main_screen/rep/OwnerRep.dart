import 'package:medhealth/common/BaseApi.dart';
import '../dto/BranchDto.dart';
import '../dto/ManagerDto.dart';

class OwnerRep {
  final BaseApi _api = BaseApi();

  Future<Response> fetchBranches() async => _api.fetch("api/branches/");

  Future<Response> createBranch(String address) async {
    return _api.post("api/branches/", {
      "address": address,
      "description": "Новый филиал",
      "clinic_owner_id": 17 // ID твоего владельца из БД
    });
  }

  Future<Response> updateBranch(int id, Map<String, dynamic> data) async =>
      _api.patch("api/branches/$id/", data);

  Future<Response> deleteBranch(int id) async =>
      _api.delete("api/branches/$id/");

  Future<Response> fetchManagers() async => _api.fetch("api/managers/");

  // Этот метод нужен для AddManagerModel
  Future<Response> createManager(Map<String, dynamic> data) async {
    return _api.post("api/managers/", data);
  }

  Future<Response> deleteManager(int id) async =>
      _api.delete("api/users/$id/");

  Future<Response> updateGlobalHolidays(String text, List<int> ids) async {
    int code = 200;
    for (var id in ids) {
      final res = await _api.patch("api/branches/$id/", {"description": text});
      code = res.code;
    }
    return Response(code: code, body: {});
  }
}