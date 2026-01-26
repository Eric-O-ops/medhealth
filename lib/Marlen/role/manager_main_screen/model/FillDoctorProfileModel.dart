import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/BaseScreenModel.dart';
import '../dto/DoctorDto.dart';
import '../rep/ManagerRep.dart';

class FillDoctorProfileModel extends BaseScreenModel {
  final ManagerRep _rep = ManagerRep();

  DoctorDto? selectedDoctor;
  File? profileImage;

  final priceCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final eduCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  String gender = 'male';
  List<String> selectedWorkDays = [];
  String branchOffDays = "";
  String branchWorkingHours = "";

  final List<String> specializations = [
    "Терапевт", "Хирург", "Стоматолог", "Кардиолог", "Педиатр", "ЛОР", "Невролог", "Другое",
  ];
  String selectedSpecialization = "Другое";

  @override
  Future<void> onInitialization() async {
    print("FillDoctorProfileModel инициализирован.");
  }

  Future<void> setup(DoctorDto doctor) async {
    selectedDoctor = doctor;
    _rep.setBranchId(doctor.branchId);

    await loadBranchConstraints();

    priceCtrl.text = doctor.price > 0 ? doctor.price.toString() : '';
    expCtrl.text = doctor.experience > 0 ? doctor.experience.toString() : '';
    ageCtrl.text = doctor.age > 0 ? doctor.age.toString() : '';
    eduCtrl.text = doctor.education;
    descCtrl.text = doctor.description;
    gender = (doctor.gender == 'male' || doctor.gender == 'female') ? doctor.gender : 'male';

    if (specializations.contains(doctor.specialization)) {
      selectedSpecialization = doctor.specialization;
    }

    if (doctor.offDays.isNotEmpty) {
      selectedWorkDays = doctor.offDays.split(", ").map((e) => e.trim()).where((s) => s.isNotEmpty).toList();
    }
    notifyListeners();
  }

  Future<void> loadBranchConstraints() async {
    try {
      final resp = await _rep.getBranchConstraints();
      if (resp.code == 200) {
        branchOffDays = resp.body['off_days'] ?? "";
        branchWorkingHours = resp.body['working_hours'] ?? "";
        print("DEBUG: Время филиала получено: $branchWorkingHours");
        notifyListeners();
      }
    } catch (e) {
      print("Ошибка загрузки ограничений: $e");
    }
  }

  void toggleWorkDay(String day) {
    List<String> disabled = branchOffDays.split(",").map((e) => e.trim()).toList();
    if (disabled.contains(day)) return;

    if (selectedWorkDays.contains(day)) {
      selectedWorkDays.remove(day);
    } else {
      selectedWorkDays.add(day);
    }
    notifyListeners();
  }

  void setSpecialization(String val) {
    selectedSpecialization = val;
    notifyListeners();
  }

  void setGender(String val) {
    gender = val;
    notifyListeners();
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) { print("Ошибка при выборе изображения: $e"); }
  }

  Future<void> saveProfile(VoidCallback onSuccess) async {
    if (selectedDoctor == null) return;
    isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      "specialization": selectedSpecialization,
      "price": double.tryParse(priceCtrl.text) ?? 0.0,
      "experience_years": int.tryParse(expCtrl.text) ?? 0,
      "age": int.tryParse(ageCtrl.text) ?? 0,
      "education": eduCtrl.text.trim(),
      "description": descCtrl.text.trim(),
      "gender": gender,
      "off_days": selectedWorkDays.join(", "),
      "working_hours": branchWorkingHours,
    };

    try {
      final resp = await _rep.updateDoctorProfile(selectedDoctor!.id, data, profileImage);
      if (resp.code == 200 || resp.code == 201 || resp.code == 204) {
        onSuccess();
      } else {
        print("Ошибка сохранения: ${resp.body}");
      }
    } catch (e) {
      print("Ошибка сети: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    priceCtrl.dispose(); expCtrl.dispose(); ageCtrl.dispose();
    eduCtrl.dispose(); descCtrl.dispose();
    super.dispose();
  }
}