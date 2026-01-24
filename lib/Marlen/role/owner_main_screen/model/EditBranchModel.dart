import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import '../dto/BranchDto.dart';
import '../dto/ManagerDto.dart';
import '../rep/OwnerRep.dart';

class EditBranchModel extends BaseScreenModel {
  final BranchDto branch;
  final OwnerRep _rep = OwnerRep();

  late TextEditingController addressController;

  List<ManagerDto> _managers = [];
  int? selectedManagerId;

  List<ManagerDto> get managers => _managers;

  EditBranchModel({required this.branch}) {
    addressController = TextEditingController(text: branch.address);
  }
  void setOwnerId(int id) {
    _rep.setOwnerId(id);
    loadManagers();
  }
  @override
  Future<void> onInitialization() async {
    await loadManagers();
  }

  Future<void> loadManagers() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _rep.fetchManagers();
      if (response.code == 200 && response.body is List) {
        _managers = (response.body as List)
            .map((e) => ManagerDto.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Ошибка: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBranch({required VoidCallback onSuccess}) async {
    isLoading = true;
    notifyListeners();

    final data = {
      "address": addressController.text,
      "manager": selectedManagerId,
    };

    final response = await _rep.updateBranch(branch.id, data);
    if (response.code == 200) {
      onSuccess();
    }
    isLoading = false;
    notifyListeners();
  }
}