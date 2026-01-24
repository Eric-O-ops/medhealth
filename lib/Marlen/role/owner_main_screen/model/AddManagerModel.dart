import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import '../dto/BranchDto.dart';
import '../rep/OwnerRep.dart';

class AddManagerModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  List<BranchDto> _branches = [];
  int? selectedBranchId;
  List<BranchDto> get branches => _branches;
// Добавляем метод
  void setOwnerId(int id) {
    _rep.setOwnerId(id);
    loadBranches();
  }
  @override
  Future<void> onInitialization() async {
    _branches = [];
    selectedBranchId = null;
    await loadBranches();
  }

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
      debugPrint("AddManagerModel Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createManager({
    required VoidCallback onSuccess,
    required Function(String) onError
  }) async {
    if (selectedBranchId == null) {
      onError("Выберите филиал!");
      return;
    }

    isLoading = true;
    notifyListeners();

    final data = {
      "user": {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(), // Для авторизации Django
        "password_user": passwordController.text.trim(),
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "role": "manager",
        "phone_number": "0000000000",
        "date_of_birth": "2000-01-01",
        "address": "Bishkek",
      },
      "branch_id": selectedBranchId,
    };

    try {
      final response = await _rep.createManager(data);
      if (response.code == 201 || response.code == 200) {
        onSuccess();
      } else {
        onError("Ошибка сервера: ${response.body}");
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
  void notify() {
    notifyListeners();
  }
}