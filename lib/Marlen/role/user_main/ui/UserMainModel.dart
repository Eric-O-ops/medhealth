import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:flutter/material.dart'; // Нужен для ChangeNotifier/notifyListeners

// Замените medhealth/common/BaseScreenModel.dart на ваш актуальный путь
// Если BaseScreenModel наследуется от ChangeNotifier, то дополнительный import не нужен

class UserMainModel extends BaseScreenModel {

  // --- Состояние ---
  int _selectedIndex = 0; // Индекс выбранной вкладки

  // --- Геттеры ---
  int get selectedIndex => _selectedIndex;

  @override
  Future<void> onInitialization() async {
    // Здесь можно загрузить данные пользователя при старте
    print("UserMainModel инициализирован.");
  }

  // --- Логика ---
  void setTabIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
      // Опционально: здесь можно вызывать загрузку данных для конкретной вкладки
      // loadDataForTab(index);
    }
  }

  // Пример метода загрузки данных (для каждой вкладки можно создать свой)
  Future<void> loadDashboardData() async {
    isLoading = true;
    // Имитация задержки API
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
    // Здесь можно обновлять специфичные поля данных
  }
}