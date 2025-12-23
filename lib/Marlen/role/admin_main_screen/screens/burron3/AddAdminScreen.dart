import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
import 'AddAdminModel.dart';

class AddAdminScreen extends StatefulWidget {
  const AddAdminScreen({super.key});

  @override
  State<AddAdminScreen> createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends BaseScreen<AddAdminScreen, AddAdminModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, AddAdminModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Новый администратор",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.admin_panel_settings, size: 80, color: AppColors.blue),
              const SizedBox(height: 20),
              const Text("Создание учетной записи администратора",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              CustomTextFuild(
                label: "Email",
                hintText: "admin@example.com",
                controller: viewModel.emailController,
                validator: Validator.validateEmail
              ),
              const SizedBox(height: 15),
              CustomTextFuild(
                label: "Пароль",
                hintText: "Минимум 8 символов",
                controller: viewModel.passwordController,
                validator: Validator.validatePassword
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
                      viewModel.createAdmin(
                        onSuccess: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Админ добавлен")));
                          Navigator.pop(context);
                        },
                        onError: (err) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err))),
                      );
                    }
                  },
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Создать", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}