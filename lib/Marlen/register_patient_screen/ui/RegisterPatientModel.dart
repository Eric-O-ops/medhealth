import 'package:flutter/material.dart';
import '../../../common/BaseApi.dart';
// Предполагаем, что BaseScreenModel находится здесь
import '../../../common/BaseScreenModel.dart';

class RegisterPatientModel extends BaseScreenModel {

  String firstName = "";
  String lastName = "";
  String dateOfBirth = "";
  String email = "";
  String phone = "";
  String address = "";
  String password = "";
  String passwordUser = ""; //

  bool hiddenPassword = true;

  @override
  Future<void> onInitialization() async {}

  void togglePassword() {
    hiddenPassword = !hiddenPassword;
    notifyListeners();
  }

  Future<bool> register(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return false;

    isLoading = true;

    final api = BaseApi();
    bool success = false;

    try {
      final response = await api.post(
        "api/users/",
        {
          "first_name": firstName,
          "last_name": lastName,
          "phone_number": phone,
          "address": address,
          "email": email,
          "date_of_birth": dateOfBirth,
          "password": password,
          "password_user": password,

          "role": "patient"
        },
      );

      success = response.code == 201;

    } catch (e) {
      isError = true;
      success = false;
    } finally {
      isLoading = false;
    }

    return success;
  }
}