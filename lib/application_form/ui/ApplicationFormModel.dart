import 'package:flutter/cupertino.dart';
import 'package:medhealth/application_form/ui/success_screen/SuccessScreen.dart';
import 'package:medhealth/common/BaseScreenModel.dart';

import '../model/ApplicationFromDto.dart';
import '../rep/ApplicationFormRep.dart';

class ApplicationFormModel extends BaseScreenModel {

  final ApplicationFormRep _rep = ApplicationFormRep();
  late ApplicationFromDto _form;

  String firstName = "";
  String lastName = "";
  String nameClinic = "";
  String email = "";
  String phoneNumber = "";
  String description = "";

  @override
  Future<void> onInitialization() async {

  }

  void sentApplicationForm({required void Function() onSuccess, required void Function() onError}) async {
      _form = ApplicationFromDto(
          firstName: firstName,
          lastName: lastName,
          nameClinic: nameClinic,
          email: email,
          phoneNumber: phoneNumber,
          description: description
      );

      final response = await _rep.postApplicationForm(_form.toJson());

      if(response.code == 201) {
        onSuccess();
      } else {
        onError();
      }

  }
}