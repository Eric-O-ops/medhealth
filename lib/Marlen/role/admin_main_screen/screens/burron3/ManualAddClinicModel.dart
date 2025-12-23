import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:medhealth/common/BaseApi.dart';

class ManualAddClinicModel extends BaseScreenModel {
  @override
  Future<void> onInitialization() async {}
  final BaseApi _api = BaseApi();

  final clinicNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> saveClinic({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    isLoading = true;
    notifyListeners();

    final data = {
      "name_clinic": clinicNameController.text,
      "user": {
        "email": emailController.text,
        "password": passwordController.text,
        "password_user": passwordController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "phone_number": phoneController.text,
        "date_of_birth": "2000-01-01",
        "address": "г.Бишкек",
        "role": "owner"
      }
    };

    try {
      final response = await _api.post("api/owners/", data);
      if (response.code == 201) {
        onSuccess();
      } else {
        onError("Ошибка сервера: ${response.code}");
      }
    } catch (e) {
      onError("Ошибка сети: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    clinicNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}