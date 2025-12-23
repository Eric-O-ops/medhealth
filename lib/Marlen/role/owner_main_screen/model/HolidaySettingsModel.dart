import 'package:flutter/material.dart'; // Нужен для TextEditingController
import 'package:medhealth/common/BaseScreenModel.dart';
import '../rep/OwnerRep.dart';

class HolidaySettingsModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();

  @override
  Future<void> onInitialization() async {
    // Можно оставить пустым
  }

  // Список выбранных дней (Сб, Вс и т.д.)
  List<String> selectedDays = [];

  // Контроллер для ввода текста праздника (например, "8 марта")
  final holidayNoteController = TextEditingController();

  // Логика выбора/снятия выбора дня
  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
  }

  // Основная функция сохранения
  Future<void> saveGlobalSettings(List<int> branchIds, VoidCallback onSuccess) async {
    if (branchIds.isEmpty) return;

    isLoading = true;
    notifyListeners();

    // Склеиваем выбранные дни и текст из поля в одну строку
    String finalHolidayText = "${selectedDays.join(", ")} ${holidayNoteController.text}".trim();

    try {
      // Отправляем запрос в репозиторий
      final response = await _rep.updateGlobalHolidays(finalHolidayText, branchIds);

      // Если хотя бы один запрос прошел успешно (200 или 204)
      if (response.code == 200 || response.code == 204) {
        onSuccess();
      }
    } catch (e) {
      debugPrint("Ошибка при сохранении настроек: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    holidayNoteController.dispose();
    super.dispose();
  }
}