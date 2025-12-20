import 'package:medhealth/common/BaseApi.dart';

class ApiBranches extends BaseApi {

  Future<Response> fetchBranches() async {
      return fetch("api/branches/");
  }

  Future<Response> patchBranches(int id, String address) async {
    return patch("api/branches/$id/", {"address": address});
  }

  Future<Response> postBranches(Map<String, dynamic> postData) async {
    return post("api/branches/", postData);
  }

  Future<Response> deleteBranches(int id) async {
    return delete("api/branches/$id/");
  }

}