import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../dto/DoctorDto.dart';
import '../model/AddDoctorModel.dart';

class EditDoctorScreen extends StatefulWidget {
  final DoctorDto doctor;
  final VoidCallback onUpdated;

  const EditDoctorScreen({
    super.key,
    required this.doctor,
    required this.onUpdated,
  });

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Инициализируем данные (email берем из объекта врача, если он там есть)
    emailController = TextEditingController(text: widget.doctor.email);
    firstNameController = TextEditingController(text: widget.doctor.firstName);
    lastNameController = TextEditingController(text: widget.doctor.lastName);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddDoctorModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Редактировать врача"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFuild(
                label: "Имя",
                hintText: "",
                controller: firstNameController,
                validator: Validator.validateName,
              ),
              CustomTextFuild(
                label: "Фамилия",
                hintText: "",
                controller: lastNameController,
                validator: Validator.validateName,
              ),
              CustomTextFuild(
                label: "Email",
                hintText: "",
                controller: emailController,
                validator: Validator.validateEmail,
              ),
              CustomTextFuild(
                label: "Новый Пароль",
                hintText: "Оставьте пустым, если не меняете",
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
                  }
                  return Validator.validatePassword(value);
                }
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  // ... ваши импорты

                  onPressed: vm.isLoading ? null : () async {
                    print("Нажата кнопка сохранения...");

                    if (_formKey.currentState == null) {
                      print("Ошибка: _formKey.currentState is null");
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      print("Валидация прошла успешно. Подготовка данных...");

                      final Map<String, dynamic> updateData = {
                        "first_name": firstNameController.text.trim(),
                        "last_name": lastNameController.text.trim(),
                        "email": emailController.text.trim(),
                      };

                      if (passwordController.text.isNotEmpty) {
                        updateData["password"] = passwordController.text.trim();
                        updateData["password_user"] = passwordController.text.trim();
                      }

                      print("Отправка запроса для userId: ${widget.doctor.userId} с данными: $updateData");

                      try {
                        bool success = await vm.updateDoctorAccount(widget.doctor.userId, updateData);
                        print("Результат запроса: $success");

                        if (success) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Успешно обновлено!"), backgroundColor: Colors.green),
                            );
                            widget.onUpdated();
                            Navigator.pop(context);
                          }
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Ошибка сервера. Проверьте Email или логи."), backgroundColor: Colors.red),
                            );
                          }
                        }
                      } catch (e) {
                        print("Критическая ошибка при нажатии: $e");
                      }
                    } else {
                      print("Валидация не прошла! Проверьте корректность полей (Email, Имя и т.д.)");
                    }
                  },
                  child: vm.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Сохранить изменения", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}