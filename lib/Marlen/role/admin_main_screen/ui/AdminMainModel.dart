import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:flutter/material.dart';
import '../../../../application_form/model/ApplicationFromDto.dart';
import '../../../../application_form/rep/ApplicationFormRep.dart';
import '../../../login_screen/dto/LoginUserDto.dart';
import '../../../login_screen/rep/LoginFormRep.dart';

class AdminMainModel extends BaseScreenModel {
  final ApplicationFormRep _rep = ApplicationFormRep();
  final LoginFormRep _userRep = LoginFormRep(); // Для загрузки пользователей

  // --- Состояние ---
  int _selectedIndex = 1;
  List<ApplicationFromDto> _pendingRequests = [];
  List<LoginUserDto> _privilegedUsers = []; // Список админов и владельцев

  // --- Геттеры ---
  int get selectedIndex => _selectedIndex;
  List<ApplicationFromDto> get pendingRequests => _pendingRequests;
  int get pendingRequestsCount => _pendingRequests.length;
  List<LoginUserDto> get privilegedUsers => _privilegedUsers;

  @override
  Future<void> onInitialization() async {
    print("AdminMainModel инициализирован.");
    await loadDashboardData();
  }

  // --- Логика переключения табов ---
  void setTabIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();

      // Загружаем данные в зависимости от выбранной вкладки
      if (index == 1) {
        loadRequests();
      } else if (index == 0) {
        loadPrivilegedUsers();
      }
    }
  }

  // Общая загрузка
  Future<void> loadDashboardData() async {
    isLoading = true;
    // Загружаем оба списка параллельно для скорости
    await Future.wait([
      loadRequests(),
      loadPrivilegedUsers(),
    ]);
    isLoading = false;
  }

  // Загрузка заявок
  Future<void> loadRequests() async {
    try {
      final response = await _rep.fetchApplicationForm();
      if (response.code == 200 && response.body is List) {
        _pendingRequests = (response.body as List)
            .map((json) => ApplicationFromDto.fromJson(json))
            .toList();
      } else {
        _pendingRequests = [];
      }
    } catch (e) {
      print("Ошибка заявок: $e");
    }
    notifyListeners();
  }

  // Загрузка пользователей (Админы и Владельцы)
  Future<void> loadPrivilegedUsers() async {
    try {
      final allUsers = await _userRep.getUsers();
      // Фильтруем список на стороне клиента
      _privilegedUsers = allUsers
          .where((u) => u.role == 'admin' || u.role == 'owner')
          .toList();
    } catch (e) {
      print("Ошибка загрузки пользователей: $e");
    }
    notifyListeners();
  }

  // Отклонение заявки
  Future<void> rejectRequest(int requestId) async {
    isLoading = true;
    final response = await _rep.rejectApplicationForm(requestId);

    if (response.code == 204) {
      _pendingRequests.removeWhere((req) => req.id == requestId);
    }
    isLoading = false;
  }

  // ⭐️ Метод для удаления пользователя
  Future<void> deleteUser(int userId) async {
    isLoading = true;
    // Используем BaseApi напрямую для удаления
    final response = await _userRep.deleteUser(userId); // Вам нужно добавить этот метод в LoginFormRep

    if (response.code == 204) {
      _privilegedUsers.removeWhere((u) => u.id == userId);
    }
    isLoading = false;
  }
}