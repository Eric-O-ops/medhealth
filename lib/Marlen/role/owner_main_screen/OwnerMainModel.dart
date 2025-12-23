import 'package:medhealth/Marlen/role/owner_main_screen/rep/OwnerRep.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:flutter/material.dart';

import 'dto/BranchDto.dart';
import 'dto/ManagerDto.dart';

class OwnerMainModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();

  // --- Состояние ---
  int _selectedIndex = 0;
  List<ManagerDto> _managers = [];
  List<BranchDto> _branches = [];

  // --- Геттеры ---
  int get selectedIndex => _selectedIndex;
  List<ManagerDto> get managers => _managers;
  List<BranchDto> get branches => _branches;

  @override
  Future<void> onInitialization() async {
    print("OwnerMainModel инициализирован.");
    await loadBranches(); // Загружаем филиалы при старте
  }

  // --- Логика переключения табов ---
  void setTabIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();

      // Загружаем данные в зависимости от вкладки
      if (index == 0) loadBranches();
      if (index == 1) loadManagers();

    }
  }

  // --- Работа с Менеджерами ---
  Future<void> loadManagers() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _rep.fetchManagers();

      // ВАЖНО: Посмотри в консоль, что тут напечатает!
      print("ОТВЕТ ОТ СЕРВЕРА (Менеджеры): ${response.body}");

      if (response.code == 200) {
        if (response.body is List) {
          _managers = (response.body as List)
              .map((e) => ManagerDto.fromJson(e))
              .toList();
        } else if (response.body is Map && response.body.containsKey('results')) {
          // Если бэкенд возвращает список внутри ключа 'results'
          _managers = (response.body['results'] as List)
              .map((e) => ManagerDto.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      print("Ошибка при разборе менеджеров: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteManager(int id) async {
    isLoading = true;
    notifyListeners();
    final response = await _rep.deleteManager(id);
    if (response.code == 204) {
      _managers.removeWhere((m) => m.id == id);
    }
    isLoading = false;
    notifyListeners();
  }

  // --- Работа с Филиалами ---
  Future<void> loadBranches() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _rep.fetchBranches();
      if (response.code == 200 && response.body is List) {
        _branches = (response.body as List)
            .map((e) => BranchDto.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Ошибка загрузки филиалов: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}