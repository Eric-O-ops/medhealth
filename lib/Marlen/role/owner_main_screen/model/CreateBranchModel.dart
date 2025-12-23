import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreenModel.dart';
import '../rep/OwnerRep.dart';

class CreateBranchModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();
  final addressController = TextEditingController();

  @override
  Future<void> onInitialization() async {
  }
  Future<void> create(VoidCallback onSuccess) async {
    if (addressController.text.isEmpty) return;

    isLoading = true;
    notifyListeners();

    // Передаем только адрес. Никаких цифр типа 11!
    final response = await _rep.createBranch(addressController.text);

    if (response.code == 201 || response.code == 200) {
      onSuccess();
    } else {
      print("ОШИБКА СОЗДАНИЯ ФИЛИАЛА: ${response.body}");
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}