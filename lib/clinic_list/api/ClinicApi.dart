import 'package:medhealth/common/BaseApi.dart';

class ClinicApi extends BaseApi {
  Future<Response> fetchClinics() {
    return fetch("api/owners/");
  }

  Future<Response> fetchBranchesClinic(int id) {
    return fetch("/branches/owner/$id/");
  }

  Future<Response> fetchFilteredClinicsAndBranches(
    List<String> clinicName,
    List<String> specialization,
  ) {

    return fetch(
      "api/branch-filters/?clinic_name=${clinicName.join(',')}&specialization=${specialization.join(',')}",
    );
  }
}
