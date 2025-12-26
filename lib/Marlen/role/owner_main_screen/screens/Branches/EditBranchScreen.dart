import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
// Проверь эти пути, они должны быть корректными в твоем проекте
import '../../../../../clinic_owner_screens/ui/add_manager /AddManagerModel.dart';
import '../../../../../clinic_owner_screens/ui/add_manager /AddManagerScreen.dart';
import '../../model/EditBranchModel.dart';
import '../../dto/BranchDto.dart';

class EditBranchScreen extends StatefulWidget {
  final BranchDto branch;
  const EditBranchScreen({super.key, required this.branch});

  @override
  State<EditBranchScreen> createState() => _EditBranchScreenState();
}

class _EditBranchScreenState extends BaseScreen<EditBranchScreen, EditBranchModel> {


  // EditBranchScreen.dart
  @override
  Widget buildBody(BuildContext context, EditBranchModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Редактировать филиал"),
        foregroundColor: Colors.black,
      ),
      body: viewModel.isLoading && viewModel.managers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFuild(
              label: "Адрес филиала",
              hintText: "Введите новый адрес",
              controller: viewModel.addressController,
              validator: (value) => (value == null || value.trim().isEmpty) ? "Обязательно" : null,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                onPressed: () => viewModel.updateBranch(
                    onSuccess: () => Navigator.pop(context, true)
                ),
                child: viewModel.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Сохранить изменения", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}