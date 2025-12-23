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

  @override
  Future<void> onInitialization() async {
    await loadBranches();
  }

  Future<void> loadBranches() async {
    isLoading = true;
    notifyListeners();
    final response = await _rep.fetchBranches();
    if (response.code == 200 && response.body is List) {
      _branches = (response.body as List).map((e) => BranchDto.fromJson(e)).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createManager({required VoidCallback onSuccess, required Function(String) onError}) async {
    if (selectedBranchId == null) {
      onError("Выберите филиал!");
      return;
    }

    isLoading = true;
    notifyListeners();

    // ВАЖНО: Структура под твой бэкенд
    final data = {
      "user": {
        "email": emailController.text,
        "password": passwordController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "role": "manager",
      },
      "branch_id": selectedBranchId,
    };

    try {
      final response = await _rep.createManager(data);
      if (response.code == 201 || response.code == 200) {
        onSuccess();
      } else {
        onError("Ошибка сервера: ${response.code}");
      }
    } catch (e) {
      onError("Ошибка сети");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}