import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/Marlen/login_screen/ui/LoginFormModel.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/common/view/CustomTextFieldPassword.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';

import '../../role/owner_main_screen/OwnerMainModel.dart';

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
        body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/images/Logo.svg',height: 110),

              SizedBox(height: 10),
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

              // Email
              CustomTextFuild(
                label: "Email",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validator.validateEmail(value),
                onChanged: (value) => viewModel.email = value ?? '',
              ),
              const SizedBox(height: 20),

              // Password
              CustomTextFieldPassword(
                label: "Пароль",
                hintText: "Введите пароль",
                isObscure: viewModel.isHidden,
                validator: (value) => Validator.validatePassword(value),
                onChanged: (value) => viewModel.password = value ?? '',
                onTapSuffixIcon: viewModel.togglePasswordVisibility,
              ),
              // Кнопка забыли пароль
              Align(alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/recovery'),
                  child: const Text(
                    "Забыли пароль?",
                    style: TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final role = await viewModel.login();

                      if (role == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Неверный email или пароль"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Перенаправление по роли
                        switch (role) {
                          case "owner":
                        final clinicId = viewModel.clinicOwnerId;
                        print("ID для передачи через аргументы: $clinicId");

                        if (clinicId != null) {
                        // Передаем clinicId как аргумент
                        Navigator.pushReplacementNamed(
                        context,
                        '/ownerMain',
                        arguments: clinicId
                        );
                        }
                        break;

                          case "doctor":
                            Navigator.pushReplacementNamed(context, '/doctorMain');
                            break;

                          case "manager":
                            Navigator.pushReplacementNamed(context, '/managerMain');
                            break;

                          case "admin":
                            Navigator.pushReplacementNamed(context, '/adminMain');
                            break;

                          case "patient":
                          case "user":
                            Navigator.pushReplacementNamed(context, '/userMain');
                            break;

                          default:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Неизвестная роль")),
                            );
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Войти",
                    style: TextStyle(
                        fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 110),
              const Text(
                "У вас  нету аккаунта?",
                style: TextStyle(fontSize: 16, color: AppColors.blue, fontWeight: FontWeight.w900),
              ),const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/registerPatient'),
                  child: const Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 75),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/helpsscreen'),
                child: const Text(
                  "Помощь",
                  style: TextStyle(
                    color: AppColors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,        // подчёркивание
                    decorationColor: AppColors.blue,              // цвет подчёркивания
                    decorationThickness: 1,                       // толщина линии
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
