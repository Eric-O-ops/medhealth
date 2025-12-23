// import 'package:medhealth/clinic_owner_screens/api/ApiBranches.dart';
// import 'package:medhealth/clinic_owner_screens/model/BranchesDto.dart';
//
// class ClinicOwnerRep {
//   final _api = ApiBranches();
//
//   Future<List<BranchDto>> getBranches() async {
//     final response = await _api.fetchBranches();
//     List<BranchDto> branchesDto = [];
//
//     if (response.code == 200) {
//       final branches = response.body as List<dynamic>;
//
//       for (var branch in branches) {
//         branchesDto.add(BranchDto.fromJson(branch));
//       }
//
//       return branchesDto;
//     } else {
//       return [];
//     }
//   }
//
//   Future<bool> updateAddressBranch(int id, String address) async {
//     final response = await _api.patchBranches(id, address);
//
//     if (response.code == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Future<bool> postBranches(String address) async {
//     final description = "some description";
//     final clinicOwner = 6;
//
//     final postData = {
//       "address": address,
//       "description": description,
//       "clinic_owner_id": clinicOwner
//     };
//
//     final response = await _api.postBranches(postData);
//
//     if (response.code == 201) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Future<bool> deleteBranches(int id) async {
//     final response = await _api.deleteBranches(id);
//
//     if (response.code == 204) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
