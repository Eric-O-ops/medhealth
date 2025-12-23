import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../model/CreateBranchModel.dart';

class CreateBranchScreen extends StatefulWidget {
  const CreateBranchScreen({super.key});

  @override
  State<CreateBranchScreen> createState() => _CreateBranchScreenState();
}

class _CreateBranchScreenState extends BaseScreen<CreateBranchScreen, CreateBranchModel> {
  @override
  Widget buildBody(BuildContext context, CreateBranchModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text("Новый филиал")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextFuild(
              label: "Адрес",
              hintText: "Введите адрес филиала",
              controller: viewModel.addressController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Адрес филиала обязателен для заполнения";
                }
                if (value.trim().length < 1) {
                  return "Адрес должен содержать минимум 1 символ";
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                onPressed: () => viewModel.create(() => Navigator.pop(context, true)),
                child: viewModel.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Создать филиал", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}