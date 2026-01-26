import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/Marlen/login_screen/ui/LoginFormModel.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/common/view/CustomTextFieldPassword.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/RAM.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreen<LoginScreen, LoginFormModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, LoginFormModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.blue, size: 30),
            onPressed: () {
              // Входим как гость: очищаем RAM и переходим на главный экран
              Ram().userId = "";
              Navigator.pushReplacementNamed(context, '/userMain');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SvgPicture.asset('assets/images/Logo.svg', height: 110),
              const SizedBox(height: 10),
              const Text(
                "Добро пожаловать",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 15),
              const Text(
                "У вас есть аккаунт?",
                style: TextStyle(fontSize: 16, color: AppColors.blue, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 15),
              CustomTextFuild(
                label: "Email",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validator.validateEmail(value),
                onChanged: (value) => viewModel.email = value ?? '',
              ),
              const SizedBox(height: 20),
              CustomTextFieldPassword(
                label: "Пароль",
                hintText: "Введите пароль",
                isObscure: viewModel.isHidden,
                validator: (value) => Validator.validatePassword(value),
                onChanged: (value) => viewModel.password = value ?? '',
                onTapSuffixIcon: viewModel.togglePasswordVisibility,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/recovery'),
                  child: const Text(
                    "Забыли пароль?",
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final role = await viewModel.login();
                      if (role == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Неверный email или пароль"), backgroundColor: Colors.red),
                        );
                      } else {
                        _handleNavigation(role, viewModel);
                      }
                    }
                  },
                  child: const Text("Войти", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
              const Text("У вас нету аккаунта?", style: TextStyle(fontSize: 16, color: AppColors.blue, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/registerPatient'),
                  child: const Text("Зарегистрироваться", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/helpsscreen'),
                child: const Text("Помощь", style: TextStyle(color: AppColors.blue, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigation(String role, LoginFormModel viewModel) {
    switch (role) {
      case "admin":
        Navigator.pushReplacementNamed(context, '/adminMain');
        break;
      case "owner":
        if (viewModel.clinicOwnerId != null) {
          Navigator.pushReplacementNamed(context, '/ownerMain', arguments: viewModel.clinicOwnerId);
        }
        break;
      case "doctor":
        Navigator.pushReplacementNamed(context, '/doctorMain');
        break;
      case "manager":
        if (viewModel.managerBranchId != null) {
          Navigator.pushReplacementNamed(context, '/managerMain', arguments: viewModel.managerBranchId);
        }
        break;
      case "patient":
      case "user":
        Navigator.pushReplacementNamed(context, '/userMain');
        break;
    }
  }
}