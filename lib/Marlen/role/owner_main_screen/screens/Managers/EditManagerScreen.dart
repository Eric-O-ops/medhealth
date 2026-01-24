import 'package:flutter/material.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../dto/ManagerDto.dart';

class EditManagerScreen extends StatefulWidget {
  final ManagerDto manager;
  const EditManagerScreen({super.key, required this.manager});

  @override
  State<EditManagerScreen> createState() => _EditManagerScreenState();
}

class _EditManagerScreenState extends State<EditManagerScreen> {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.manager.email);
    firstNameController = TextEditingController(text: widget.manager.firstName);
    lastNameController = TextEditingController(text: widget.manager.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Редактировать профиль"), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextFuild(
              label: "Имя",
              hintText: "Введите имя",
              controller: firstNameController,
                validator: Validator.validateName
            ),
            CustomTextFuild(
              label: "Фамилия",
              hintText: "Введите фамилию",
              controller: lastNameController,
                validator: Validator.validateName
            ),
            CustomTextFuild(
              label: "Email",
              hintText: "example@mail.com",
              controller: emailController,
              validator: Validator.validateEmail,
            ),
            CustomTextFuild(
              label: "Новый Пароль",
              hintText: "Оставьте пустым, если не меняете",
              controller: passwordController,
              validator: Validator.validatePassword,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),

                onPressed: () {
                  final String newPass = passwordController.text.trim();

                  // Создаем ПЛОСКУЮ структуру данных для модели User
                  final Map<String, dynamic> updateData = {
                    "first_name": firstNameController.text.trim(),
                    "last_name": lastNameController.text.trim(),
                    "email": emailController.text.trim(),
                  };

                  if (newPass.isNotEmpty) {
                    updateData["password"] = newPass;
                    updateData["password_user"] = newPass;
                  }

                  Navigator.pop(context, updateData);
                },

                child: const Text("Сохранить изменения", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}