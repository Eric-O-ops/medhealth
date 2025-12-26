import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';

import '../dto/DoctorDto.dart';
import '../rep/ManagerRep.dart';

class ManagerMainModel extends BaseScreenModel {
  @override
  Future<void> onInitialization() {
    // TODO: implement onInitialization
    throw UnimplementedError();
  }
  final ManagerRep _rep = ManagerRep();

  List<DoctorDto> _doctors = [];
  List<DoctorDto> get doctors => _doctors;

  int? currentBranchId; // ID филиала, к которому привязан менеджер
  int? currentManagerId;

  // Контроллеры для форм
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController(); // Врачу нужен пароль для входа
  final phoneCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final educationCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  // Выбранная специальность
  String selectedSpecialization = 'therapist';
  final List<String> specializations = ['therapist', 'surgeon', 'pediatrician', 'dentist'];

  // Инициализация: передаем ID юзера (менеджера), который вошел в систему
  Future<void> initManager(int userId) async {
    isLoading = true;
    notifyListeners();

    try {
      // 1. Узнаем, к какому филиалу привязан этот менеджер
      // Предполагаем, что api/managers/?user=ID вернет список с 1 элементом
      final response = await _rep.getManagerInfo(userId);

      if (response.code == 200 && (response.body as List).isNotEmpty) {
        final managerData = response.body[0];
        // managerData['branch'] может быть int или объектом, зависит от сериализатора
        if (managerData['branch'] is int) {
          currentBranchId = managerData['branch'];
        } else {
          currentBranchId = managerData['branch']['id'];
        }

        print("Менеджер привязан к филиалу ID: $currentBranchId");

        // 2. Загружаем врачей этого филиала
        if (currentBranchId != null) {
          await loadDoctors();
        }
      }
    } catch (e) {
      print("Ошибка инициализации менеджера: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDoctors() async {
    if (currentBranchId == null) return;

    try {
      final res = await _rep.getDoctors(currentBranchId!);
      if (res.code == 200) {
        _doctors = (res.body as List).map((e) => DoctorDto.fromJson(e)).toList();
      }
    } catch (e) {
      print("Ошибка загрузки врачей: $e");
    }
    notifyListeners();
  }

  // Сохранение (Создание или Редактирование)
  Future<void> saveDoctor({
    required bool isEditing,
    int? docId,
    int? userId, // ID юзера для PATCH запроса
    required VoidCallback onSuccess
  }) async {
    if (currentBranchId == null) return;

    isLoading = true;
    notifyListeners();

    // Собираем данные. Структура зависит от вашего DoctorSerializer
    final Map<String, dynamic> data = {
      "branch_id": currentBranchId, // Обязательно передаем ID филиала
      "experience_years": int.tryParse(expCtrl.text) ?? 0,
      "education": educationCtrl.text,
      "description": descCtrl.text,
      // "specialization": selectedSpecialization, // Если добавите поле в модель Django
    };

    // Если создаем нового, нужно передать данные User (email, pass, name)
    if (!isEditing) {
      data["user"] = {
        "email": emailCtrl.text,
        "password": passwordCtrl.text,
        "first_name": firstNameCtrl.text,
        "last_name": lastNameCtrl.text,
        "phone_number": phoneCtrl.text,
        "role": "doctor",
        "date_of_birth": "1990-01-01", // Заглушка
        "address": "Bishkek" // Заглушка
      };
    } else {
      // Логика обновления сложнее: обычно обновляем профиль врача и профиль User отдельно
      // Для простоты пока обновим только поля Врача
    }

    try {
      if (isEditing && docId != null) {
        // Обновление
        await _rep.updateDoctor(docId, data);
      } else {
        // Создание
        await _rep.createDoctor(data);
      }
      onSuccess();
      await loadDoctors(); // Обновляем список
    } catch (e) {
      print("Ошибка сохранения: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteDoctor(int userId) async {
    await _rep.deleteDoctorUser(userId);
    await loadDoctors();
  }

  // Очистка полей перед открытием диалога
  void clearFields() {
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    phoneCtrl.clear();
    expCtrl.clear();
    educationCtrl.clear();
    descCtrl.clear();
  }
}