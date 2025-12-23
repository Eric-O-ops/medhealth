import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:medhealth/common/BaseApi.dart';

import '../../../../login_screen/model/LoginUserDto.dart';

class EditUserModel extends BaseScreenModel {
  final LoginUserDto user;
  final BaseApi _api = BaseApi();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  EditUserModel({required this.user}) {
    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController(text: user.passwordUser);
  }

  @override
  Future<void> onInitialization() async {}

  // Внутри метода updateUser класса EditUserModel
  Future<void> updateUser({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    isLoading = true;

    // Данные для отправки
    final Map<String, dynamic> updateData = {
      "email": emailController.text,
      "password_user": passwordController.text,
      "password": passwordController.text, // Часто Django требует оба
      "address": "г.Бишкек", // Как мы выяснили, это поле обязательно
    };

    try {
      // ВАЖНО: убедитесь, что в BaseApi метод patch принимает String endpoint и Map data
      final response = await _api.patch("api/users/${user.id}/", updateData);

      if (response.code == 200 || response.code == 204) {
        onSuccess();
      } else {
        onError("Ошибка: ${response.code}");
      }
    } catch (e) {
      onError("Ошибка сети: $e");
    } finally {
      isLoading = false;
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}