import 'package:flutter/cupertino.dart';
import '../../../../common/BaseScreenModel.dart';
import '../dto/DoctorDto.dart';
import '../rep/ManagerRep.dart';

class DoctorScheduleModel extends BaseScreenModel {
  final ManagerRep _rep = ManagerRep();

  int? _branchId;
  int? get branchId => _branchId;

  List<DoctorDto> doctors = [];
  DoctorDto? selectedDoctor;

  String branchOffDays = "";
  String branchWorkingHours = "";

  List<String> selectedDays = [];
  final workingHoursController = TextEditingController();

  Future<void> onInitialization() async {
    print("DoctorScheduleModel инициализирован.");
  }

  void setup(int bId, List<DoctorDto> currentDoctors) {
    _branchId = bId;
    doctors = currentDoctors;
    _rep.setBranchId(bId);
    loadBranchConstraints();
  }


  Future<void> loadBranchConstraints() async {
    final resp = await _rep.getBranchConstraints();
    if (resp.code == 200) {
      branchOffDays = resp.body['off_days'] ?? "";
      branchWorkingHours = resp.body['working_hours'] ?? "";
      notifyListeners();
    }
  }

  void selectDoctor(DoctorDto? doctor) {
    selectedDoctor = doctor;
    if (doctor != null) {
      selectedDays = doctor.offDays.split(", ").where((s) => s.isNotEmpty).toList();
      workingHoursController.text = doctor.workingHours;
    }
    notifyListeners();
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
  }

  Future<void> saveSchedule(VoidCallback onSuccess) async {
    if (selectedDoctor == null) return;

    isLoading = true;
    notifyListeners();

    final data = {
      "working_hours": workingHoursController.text,
      "off_days": selectedDays.join(", "),
    };

    final resp = await _rep.updateDoctorProfile(selectedDoctor!.id, data, null);

    if (resp.code == 200 || resp.code == 204) {
      onSuccess();
    }

    isLoading = false;
    notifyListeners();
  }}