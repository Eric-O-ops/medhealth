import '../../../../common/BaseApi.dart';

class PatientRep {
  final BaseApi _api = BaseApi();

  // Получаем все клиники (используем твой новый эндпоинт в Django)
  Future<Response> fetchAllClinics() async {
    return await _api.fetch("api/patient/clinics/");
  }

  // Получаем врачей филиала (используем фильтр по branch_id)
  Future<Response> fetchDoctorsByBranch(int branchId) async {
    return await _api.fetch("api/doctors/?branch_id=$branchId");
  }
}