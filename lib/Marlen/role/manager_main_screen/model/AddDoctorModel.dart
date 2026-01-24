import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/BaseScreenModel.dart';
import '../rep/ManagerRep.dart';

class AddDoctorModel extends BaseScreenModel {
  final ManagerRep _rep = ManagerRep();
  int? _branchId;
  File? selectedImage;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  void setBranchId(int id) {
    _branchId = id;
    _rep.setBranchId(id);
  }

  @override
  Future<void> onInitialization() async {
    print("AddDoctorModel инициализирован.");
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  // ОБНОВЛЕННЫЙ МЕТОД: Исправлена ошибка "красного" метода и логика ответа
  Future<bool> updateDoctorAccount(int userId, Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    try {
      // userId берется из DoctorDto (это id из CustomUser)
      final response = await _rep.updateUserAccount(userId, data);

      if (response.code == 200 || response.code == 204) {
        print("Данные аккаунта успешно обновлены");
        return true;
      } else {
        print("Ошибка сервера (${response.code}): ${response.body}");
        return false;
      }
    } catch (e) {
      print("Ошибка сети при обновлении: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createAccount({
    required VoidCallback onSuccess,
    required Function(String) onError
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> doctorData = {
        "user": {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "first_name": firstNameController.text.trim(),
          "last_name": lastNameController.text.trim(),
          "role": "doctor",
          "phone_number": "0000000000",
          "date_of_birth": "2000-01-01",
          "address": "Bishkek",
        },
        "branch_id": _branchId,
      };

      final response = await _rep.createDoctorAccount(doctorData);

      if (response.code == 201 || response.code == 200) {
        onSuccess();
      } else {
        onError("Ошибка ${response.code}: ${response.body}");
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
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}