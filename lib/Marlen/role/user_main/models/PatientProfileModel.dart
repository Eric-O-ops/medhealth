import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medhealth/common/RAM.dart';
import 'package:medhealth/common/BaseApi.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import '../rep/PatientRep.dart';

class PatientProfileModel extends BaseScreenModel {
  final PatientRep _rep = PatientRep();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final dobCtrl = TextEditingController();

  String? photoUrl;
  String gender = 'male';
  File? profileImage;

  @override
  Future<void> onInitialization() async {
    await loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      final userId = Ram().userId;
      final resp = await BaseApi().fetch("api/users/$userId/");

      if (resp.code == 200) {
        final data = resp.body;

        firstNameCtrl.text = data['first_name']?.toString() ?? '';
        lastNameCtrl.text = data['last_name']?.toString() ?? '';
        phoneCtrl.text = data['phone_number']?.toString() ?? '';
        addressCtrl.text = data['address']?.toString() ?? '';
        dobCtrl.text = data['date_of_birth']?.toString() ?? ''; // Загрузка даты
        gender = (data['gender'] == 'female') ? 'female' : 'male';

        if (data['photo'] != null && data['photo'].toString().isNotEmpty) {
          String path = data['photo'].toString();
          String cleanPath = path.startsWith('/') ? path.substring(1) : path;

          photoUrl = path.startsWith('http')
              ? path
              : "http://127.0.0.1:8000/$cleanPath";

          photoUrl = "$photoUrl?t=${DateTime.now().millisecondsSinceEpoch}";
        } else {
          photoUrl = null;
        }
      }
    } catch (e) {
      debugPrint("Ошибка загрузки профиля: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      profileImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> saveProfile(VoidCallback onSuccess) async {
    isLoading = true;
    notifyListeners();

    final userId = Ram().userId;
    final Map<String, String> data = {
      "first_name": firstNameCtrl.text.trim(),
      "last_name": lastNameCtrl.text.trim(),
      "phone_number": phoneCtrl.text.trim(),
      "address": addressCtrl.text.trim(),
      "date_of_birth": dobCtrl.text.trim(), // Отправка даты
      "gender": gender,
    };

    try {
      final resp = await _rep.updatePatientProfile(userId, data, profileImage);
      if (resp.code == 200 || resp.code == 204) {
        profileImage = null;
        await loadProfile();
        onSuccess();
      }
    } catch (e) {
      debugPrint("Ошибка сохранения: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    dobCtrl.dispose();
    super.dispose();
  }
}