import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../../../login_screen/model/LoginUserDto.dart';
import 'EditUserModel.dart';

class EditUserScreen extends StatefulWidget {
  final LoginUserDto user;
  const EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends BaseScreen<EditUserScreen, EditUserModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, EditUserModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: const Text("Редактировать профиль")
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFuild(
                label: "Email",
                hintText: "Введите email",
                controller: viewModel.emailController,
                validator: (v) => (v == null || v.isEmpty) ? "Поле пустое" : null,
              ),
              const SizedBox(height: 20),
              CustomTextFuild(
                label: "Новый пароль",
                hintText: "Введите новый пароль",
                controller: viewModel.passwordController,
                validator: (v) => (v == null || v.length < 4) ? "Слишком короткий" : null,
              ),
              const SizedBox(height: 40),
              if (viewModel.isLoading)
                const CircularProgressIndicator()
              else
                MaterialButton(
                  color: AppColors.blue,
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      viewModel.updateUser(
                        onSuccess: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Данные обновлены")),
                          );
                          Navigator.pop(context, true); // Возвращаем true для обновления списка
                        },
                        onError: (error) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error)),
                        ),
                      );
                    }
                  },
                  child: const Text("Сохранить изменения", style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}