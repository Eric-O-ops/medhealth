import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import '../rep/OwnerRep.dart';

class HolidaySettingsModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();
  void updateOwnerId(int id) {
    _rep.setOwnerId(id);
  }

  @override
  Future<void> onInitialization() async {
  }

  List<String> selectedDays = [];

  final holidayNoteController = TextEditingController();

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
  }

  final workingHoursController = TextEditingController();

  Future<void> saveGlobalSettings(List<int> branchIds, VoidCallback onSuccess) async {
    if (branchIds.isEmpty) return;

    isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> data = {
        "description": holidayNoteController.text.trim(),
        "off_days": selectedDays.isEmpty ? "Нет" : selectedDays.join(", "),
        "working_hours": workingHoursController.text.trim(),
      };

      for (var id in branchIds) {
        final resp = await _rep.updateBranch(id, data);
        print("Обновление филиала $id: Код ${resp.code} Тело: ${resp.body}");
      }

      onSuccess();
    } catch (e) {
      print("Ошибка при массовом обновлении: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }}