import 'dart:io';
import '../../../../common/BaseApi.dart';

class ManagerRep {
  final BaseApi _api = BaseApi();
  int? _branchId; // БЕЗ static для изоляции данных

  int? get currentBranchId => _branchId;

  // Установка ID филиала
  void setBranchId(int id) {
    // Защита от случайного обнуления валидного ID
    if (id == 0 && _branchId != null && _branchId != 0) {
      print("ManagerRep: Сброс проигнорирован. Текущий ID: $_branchId");
      return;
    }
    _branchId = id;
    print("ManagerRep: Branch ID установлен в $_branchId");
  }

  // Получение данных филиала (название клиники, адрес и т.д.)
  Future<Response> fetchBranchInfo() async {
    if (_branchId == null || _branchId == 0) return Response(code: 400, body: "Branch ID not set");
    return await _api.fetch("api/branches/$_branchId/");
  }

  // Получение врачей ТОЛЬКО этого филиала
  Future<Response> fetchMyDoctors() async {
    if (_branchId == null || _branchId == 0) return Response(code: 400, body: "Branch ID not set");
    return await _api.fetch("api/doctors/?branch_id=$_branchId");
  }

  Future<Response> createDoctorAccount(Map<String, dynamic> data) async {
    data['branch_id'] = _branchId;
    return _api.post("api/doctors/", data);
  }

  Future<Response> updateDoctorProfile(int id, Map<String, dynamic> data, File? imageFile) async {
    if (imageFile != null) {
      return await _api.postWithFile("api/doctors/$id/", data, imageFile, isPatch: true);
    } else {
      return await _api.patch("api/doctors/$id/", data);
    }
  }

  Future<Response> updateUserAccount(int userId, Map<String, dynamic> data) async {
    return await _api.patch("api/users/$userId/", data);
  }

  Future<Response> deleteDoctor(int id) async {
    return await _api.delete("api/doctors/$id/");
  }

  Future<Response> getBranchConstraints() async {
    if (_branchId == null || _branchId == 0) return Response(code: 400, body: "Branch ID not set");
    return _api.fetch("api/branches/$_branchId/");
  }
}