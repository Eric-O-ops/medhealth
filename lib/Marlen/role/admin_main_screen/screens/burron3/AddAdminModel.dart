import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:medhealth/common/BaseApi.dart';

class AddAdminModel extends BaseScreenModel {
  @override
  Future<void> onInitialization() async {}
  final BaseApi _api = BaseApi();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> createAdmin({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      onError("Заполните все поля");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await _api.post("api/users/", {
        "email": emailController.text,
        "password": passwordController.text,
        "password_user": passwordController.text,
        "role": "admin",
        "first_name": "Admin", // Технические заглушки
        "last_name": "System",
        "phone_number": "000",
        "date_of_birth": "2000-01-01",
        "address": "г.Бишкек"
      });

      if (response.code == 201) {
        onSuccess();
      } else {
        onError("Ошибка: ${response.code}");
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}