import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'ManualAddClinicModel.dart';

class ManualAddClinicScreen extends StatefulWidget {
  const ManualAddClinicScreen({super.key});

  @override
  State<ManualAddClinicScreen> createState() => _ManualAddClinicScreenState();
}

class _ManualAddClinicScreenState extends BaseScreen<ManualAddClinicScreen, ManualAddClinicModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, ManualAddClinicModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Добавить клинику",style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Данные клиники", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),
              CustomTextFuild(
                label: "Название клиники",
                hintText: "Введите название",
                controller: viewModel.clinicNameController,
                validator: (v) => v!.isEmpty ? "Обязательно" : null,
              ),
              const Divider(height: 40),
              const Text("Данные владельца",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),
              CustomTextFuild(
                label: "Имя",
                hintText: "Введите имя",
                controller: viewModel.firstNameController,
                validator: Validator.validateName
              ),
              CustomTextFuild(
                label: "Фамилия",
                hintText: "Введите фамилию",
                controller: viewModel.lastNameController,
                  validator: Validator.validateName
              ),
              CustomTextFuild(
                label: "Телефон",
                hintText: "Введите номер",
                controller: viewModel.phoneController,
                  validator: Validator.validatePhoneNumber
              ),
              CustomTextFuild(
                label: "Email",
                hintText: "Введите почту @gmail.com",
                controller: viewModel.emailController,
                  validator: Validator.validateEmail
              ),
              CustomTextFuild(
                label: "Пароль",
                hintText: "Введите пароль",
                controller: viewModel.passwordController,
                  validator: Validator.validatePassword
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                  onPressed: viewModel.isLoading ? null : () {
                    if (_formKey.currentState!.validate()) {
                      viewModel.saveClinic(
                        onSuccess: () => Navigator.pop(context),
                        onError: (err) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err))),
                      );
                    }
                  },
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Сохранить клинику", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}