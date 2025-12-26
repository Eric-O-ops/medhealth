import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
import '../../model/AddManagerModel.dart';
import '../../model/CreateBranchModel.dart';
import '../Branches/CreateBranchScreen.dart';

class AddManagerScreen extends StatefulWidget {
  const AddManagerScreen({super.key});

  @override
  State<AddManagerScreen> createState() => _AddManagerScreenState();
}

class _AddManagerScreenState extends BaseScreen<AddManagerScreen, AddManagerModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Гарантируем, что загрузка начнется сразу при входе
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddManagerModel>().loadBranches();
    });
  }

  @override
  Widget buildBody(BuildContext context, AddManagerModel viewModel) {
    // ВАЖНО: Возвращаем Scaffold, так как в BaseScreen его недостаточно для AppBar
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Добавить менеджера"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: viewModel.isLoading && viewModel.branches.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFuild(
                label: "Имя",
                hintText: "Введите имя",
                controller: viewModel.firstNameController,
                validator: Validator.validateName,
              ),
              CustomTextFuild(
                label: "Фамилия",
                hintText: "Фамилия",
                controller: viewModel.lastNameController,
                validator: Validator.validateName,
              ),
              CustomTextFuild(
                label: "Email",
                hintText: "example@mail.com",
                controller: viewModel.emailController,
                validator: Validator.validateEmail,
              ),
              CustomTextFuild(
                label: "Пароль",
                hintText: "Введите пароль",
                validator: Validator.validatePassword,
                controller: viewModel.passwordController,
              ),
              const SizedBox(height: 20),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Привязать к филиалу:", style: TextStyle(fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: DropdownButton<int>(
                  value: viewModel.selectedBranchId,
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: const Text("Выберите филиал"),
                  items: [
                    ...viewModel.branches.map((b) => DropdownMenuItem(
                        value: b.id,
                        child: Text(b.address)
                    )),
                    const DropdownMenuItem(
                        value: -1,
                        child: Text("+ Добавить новый филиал",
                            style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold))
                    ),
                  ],
                  onChanged: (val) {
                    if (val == -1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => CreateBranchModel()..initialize(),
                            child: const CreateBranchScreen(),
                          ),
                        ),
                      ).then((_) => viewModel.loadBranches());
                    } else {
                      viewModel.selectedBranchId = val;
                      viewModel.notify();
                    }
                  },
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  onPressed: viewModel.isLoading ? null : () {
                    if (_formKey.currentState!.validate()) {
                      viewModel.createManager(
                        onSuccess: () => Navigator.pop(context, true),
                        onError: (msg) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(msg))
                        ),
                      );
                    }
                  },
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Создать менеджера", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}