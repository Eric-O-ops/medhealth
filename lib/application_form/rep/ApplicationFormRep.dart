import 'package:medhealth/application_form/api/ApplicationFormApi.dart';

import '../../common/BaseApi.dart';

class ApplicationFormRep {
  final ApplicationFormApi _api = ApplicationFormApi();

  Future<Response> postApplicationForm(Map<String, dynamic> postData) async {
    return _api.sentApplicationFrom(postData);
  }

}