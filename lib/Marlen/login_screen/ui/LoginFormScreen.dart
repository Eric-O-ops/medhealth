import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/Marlen/login_screen/ui/LoginFormModel.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/common/view/CustomTextFieldPassword.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreen<LoginScreen, LoginFormModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, LoginFormModel viewModel) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset('assets/images/Logo.svg', width: 115, height: 77),

            SizedBox(height: 8),
            const Text(
              "Добро пожаловать",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            const Text(
              "У вас есть аккаунт?",
              style: TextStyle(fontSize: 16, color: AppColors.blue, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 40),

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
            const SizedBox(height: 40),

            // Кнопка входа
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
                    } else if (role == "owner") {
                      Navigator.pushReplacementNamed(context, '/ownerMain');
                    } else if (role == "user") {
                      Navigator.pushReplacementNamed(context, '/userMain');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Неизвестная роль"),
                        ),
                      );
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

            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/recovery'),
                child: const Text(
                  "Забыли пароль?",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
