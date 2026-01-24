// import 'package:medhealth/clinic_list/api/ClinicApi.dart';
// import 'package:medhealth/clinic_list/model/BranchesAndSpecialtyDto.dart';
// import 'package:medhealth/clinic_list/model/ClinicDto.dart';
//
// class ClinicRep {
//   final api = ClinicApi();
//
//   Future<List<ClinicDto>> getClinics() async {
//     return api.fetchClinics().then((response) {
//       if (response.code == 200) {
//         return (response.body as List)
//             .map((item) => ClinicDto.fromJson(item))
//             .toList();
//       } else {
//         return List.empty();
//       }
//     });
//   }
//
//   Future<List<String>> getBranchesClinic(int nameClinic) {
//     return api.fetchBranchesClinic(nameClinic).then((response) {
//       if (response.code == 200) {
//         return (response.body as List)
//             .map((item) => item['address'] as String)
//             .toList();
//       } else {
//         return List.empty();
//       }
//     });
//   }
//
//   Future<List<BranchesAndSpecialtyDto>> getSpecializationsClinic(
//     String nameClinic,
//   ) async {
//     final specializations = [
//       'therapist',
//       'surgeon',
//       'pediatrician',
//       'cardiologist',
//       'neurologist',
//       'dentist',
//       'ophthalmologist',
//       'dermatologist',
//       'psychiatrist',
//       'other',
//     ];
//
//     final response = await api.fetchFilteredClinicsAndBranches([
//       nameClinic,
//     ], specializations);
//
//     if (response.code == 200) {
//       final body = response.body as List;
//       final List<BranchesAndSpecialtyDto> allBranches = [];
//
//       for (final clinicItem in body) {
//         final branchesJson = clinicItem['filtered_branches'];
//
//         branchesJson.forEach((item) {
//           allBranches.add(BranchesAndSpecialtyDto.fromJson(item));
//         });
//       }
//       return allBranches;
//     } else {
//       return [];
//     }
//   }
// }
