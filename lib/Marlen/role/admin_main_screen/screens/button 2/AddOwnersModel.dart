import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import '../../../../../application_form/model/ApplicationFromDto.dart';
import '../../rep/AdminRep.dart';
import '../../rep/OwnerRegistrationDto.dart';

class AddOwnersModel extends BaseScreenModel {
  final ApplicationFromDto request;
  final AdminRep _adminRep = AdminRep();

  // ⭐️ 1. Определяем контроллеры
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  // ⭐️ 2. Геттеры, берущие текст из контроллеров
  String get email => emailController.text;
  String get password => passwordController.text;

  AddOwnersModel({required this.request}) {
    // ⭐️ 3. Инициализация и предзаполнение
    emailController = TextEditingController(text: request.email);
    passwordController = TextEditingController();
  }

  @override
  Future<void> onInitialization() async {}

  // ⭐️ 4. Очистка ресурсов
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // 5. Логика createOwnerAndClinic
  Future<void> createOwnerAndClinic({
    required void Function() onSuccess,
    required void Function(String error) onError
  }) async {
    // Проверка здесь использует текст из контроллеров через геттеры
    if (email.isEmpty || password.isEmpty) {
      return onError("Почта и пароль не могут быть пустыми.");
    }

    isLoading = true;
    notifyListeners();


    final registrationData = OwnerRegistrationDto(
      email: email,
      password: password,
      clinicName: request.nameClinic,
      firstName: request.firstName,
      lastName: request.lastName,
      phoneNumber: request.phoneNumber,
      dateOfBirth: '2000-01-01',
      // password_user: password,//эти поля добавлят для создание владельца клиник owner?
      // address: '',
      // role: 'owner'
    );

    try {
      final response = await _adminRep.registerOwnerAndAddClinic(registrationData.toJson());

      if (response.code == 201) {
        onSuccess();
      } else {
        onError('Ошибка сервера: Код ${response.code}');
      }
    } catch (e) {
      onError('Ошибка сети или обработки: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}