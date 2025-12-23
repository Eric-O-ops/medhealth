import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../dto/BranchDto.dart';
import '../model/EditBranchModel.dart';

class EditBranchScreen extends StatefulWidget {
  final BranchDto branch;
  const EditBranchScreen({super.key, required this.branch});

  @override
  State<EditBranchScreen> createState() => _EditBranchScreenState();
}

class _EditBranchScreenState extends BaseScreen<EditBranchScreen, EditBranchModel> {

  @override
  Widget buildBody(BuildContext context, EditBranchModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text("Редактировать филиал")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFuild(
              label: "Адрес филиала",
              hintText: "Введите новый адрес",
              validator:(value) {
                if (value == null || value.trim().isEmpty) {
                  return "Адрес филиала обязателен для заполнения";
                }
                if (value.trim().length < 1) {
                  return "Адрес должен содержать минимум 1 символ";
                }
                return null;
              },
              controller: viewModel.addressController,
            ),
            const SizedBox(height: 30),
            const Text("Назначить менеджера", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Выпадающий список (Dropdown)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButton<int>(
                value: viewModel.selectedManagerId,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Выберите менеджера"),
                items: [
                  // Список существующих менеджеров
                  ...viewModel.managers.map((m) => DropdownMenuItem(
                    value: m.id,
                    child: Text("${m.firstName} ${m.lastName}"),
                  )),
                  // Кнопка перехода на добавление нового менеджера
                  const DropdownMenuItem(
                    value: -1, // Фейковый ID для действия
                    child: Text("+ Добавить нового менеджера",
                        style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
                onChanged: (val) {
                  if (val == -1) {
                    // TODO: Навигация на экран добавления менеджера
                  } else {
                    setState(() => viewModel.selectedManagerId = val);
                  }
                },
              ),
            ),

            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                onPressed: () => viewModel.updateBranch(onSuccess: () => Navigator.pop(context, true)),
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