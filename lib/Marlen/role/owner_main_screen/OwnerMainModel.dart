import 'package:medhealth/Marlen/role/owner_main_screen/rep/OwnerRep.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:flutter/material.dart';
import 'dto/BranchDto.dart';
import 'dto/ManagerDto.dart';
import 'model/BranchesModel.dart';

class OwnerMainModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();

  int _selectedIndex = 0;
  List<ManagerDto> _managers = [];
  List<BranchDto> _branches = [];
  int? ownerId;

  int get selectedIndex => _selectedIndex;
  List<ManagerDto> get managers => _managers;
  List<BranchDto> get branches => _branches;

  // 1. Метод инициализации данных для конкретного владельца
  // Вызывайте его сразу после перехода на этот экран
  void setupOwner(int id) {
    print("OwnerMainModel: Устанавливаю ID владельца = $id");
    this.ownerId = id;
    _rep.setOwnerId(id);

    // Явно запускаем загрузку данных СРАЗУ после установки ID
    loadBranches();
    loadManagers();
  }

  @override
  Future<void> onInitialization() async {
    print("OwnerMainModel инициализирован.");
    // Если ID уже пришел через setupOwner (вызванный в create провайдера)
    if (ownerId != null) {
      loadBranches();
      loadManagers();
    }
  }

  void setTabIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();

      // Подгружаем данные только если установлен ID владельца
      if (ownerId != null) {
        if (index == 0) loadBranches();
        if (index == 1) loadManagers();
      }
    }
  }
// OwnerMainModel.dart

  Future<void> loadBranches() async {
    if (ownerId == null || ownerId == 0) return;

    isLoading = true;
    notifyListeners(); // Показываем индикатор загрузки

    try {
      final response = await _rep.fetchBranches();
      print("ОТВЕТ ПО ФИЛИАЛАМ: ${response.code} | ТЕЛО: ${response.body}");

      if (response.code == 200 && response.body is List) {
        _branches = (response.body as List)
            .map((e) => BranchDto.fromJson(e))
            .toList();
        print("РАСПАРШЕНО ФИЛИАЛОВ: ${_branches.length}");
      }
    } catch (e) {
      print("Ошибка загрузки филиалов: $e");
    } finally {
      isLoading = false;
      notifyListeners(); // ОБЯЗАТЕЛЬНО: уведомляем UI, чтобы список перерисовался
    }
  }

  // --- Загрузка менеджеров ---
  Future<void> loadManagers() async {
    if (ownerId == null) return;

    isLoading = true;
    notifyListeners();
    try {
      final response = await _rep.fetchManagers();
      if (response.code == 200) {
        if (response.body is List) {
          _managers = (response.body as List)
              .map((e) => ManagerDto.fromJson(e))
              .toList();
        } else if (response.body is Map && response.body.containsKey('results')) {
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

  Future<void> deleteManager(int userId, int localManagerId) async {
    isLoading = true;
    notifyListeners();

    try {
      // Стучимся в /api/users/ID_ПОЛЬЗОВАТЕЛЯ/
      final response = await _rep.deleteManager(userId);

      if (response.code == 204 || response.code == 200) {
        // Удаляем из списка по ID МЕНЕДЖЕРА
        _managers.removeWhere((m) => m.id == localManagerId);
      } else {
        print("Ошибка удаления: ${response.body}");
      }
    } catch (e) {
      print("Ошибка сети: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Обновленный метод обновления (использует userId)
  Future<void> updateManager(int userId, Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    print("ОТПРАВЛЯЕМ PATCH НА USER ID $userId С ДАННЫМИ: $data");

    try {
      final response = await _rep.updateManager(userId, data);
      print("ДЕТАЛИ ОТ СЕРВЕРА: ${response.body}");

      if (response.code == 200 || response.code == 204) {
        await loadManagers();
      }
    } catch (e) {
      print("Ошибка: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}