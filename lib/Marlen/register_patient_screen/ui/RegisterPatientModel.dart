import 'package:flutter/material.dart';
import '../../../common/BaseApi.dart';
// Предполагаем, что BaseScreenModel находится здесь
import '../../../common/BaseScreenModel.dart';

// 1. Наследуем от BaseScreenModel
class RegisterPatientModel extends BaseScreenModel {

  String firstName = "";
  String lastName = "";
  String dateOfBirth = "";
  String email = "";
  String phone = "";
  String address = "";
  String password = ""; // Основной пароль
  String passwordUser = ""; //

  bool hiddenPassword = true;

  @override
  Future<void> onInitialization() async {}

  void togglePassword() {
    hiddenPassword = !hiddenPassword;
    notifyListeners();
  }

  Future<bool> register(GlobalKey<FormState> formKey) async {
    // 2. Используем ключ, переданный из UI (State)
    if (!formKey.currentState!.validate()) return false;

    // 3. Устанавливаем isLoading = true перед началом запроса
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
          "date_of_birth": dateOfBirth, // ИСПРАВЛЕНО

          // Отправляем основной пароль (P1) в оба поля, как просил друг
          "password": password,
          "password_user": password, // 🔥 Отправляем P1 в password_user тоже

          "role": "patient"
        },
      );

      success = response.code == 201;

    } catch (e) {
      // 4. Обрабатываем ошибку, используя встроенные флаги BaseScreenModel
      isError = true;
      // В реальном приложении: errorMessage = e.toString();
      success = false;
    } finally {
      // 5. Всегда устанавливаем isLoading = false
      isLoading = false;
    }

    return success;
  }
}