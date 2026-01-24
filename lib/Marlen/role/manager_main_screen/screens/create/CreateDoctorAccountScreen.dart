import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../model/AddDoctorModel.dart';

class CreateDoctorAccountScreen extends StatefulWidget {
  const CreateDoctorAccountScreen({super.key});

  @override
  State<CreateDoctorAccountScreen> createState() => _CreateDoctorAccountScreenState();
}

class _CreateDoctorAccountScreenState extends BaseScreen<CreateDoctorAccountScreen, AddDoctorModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, AddDoctorModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Создайте врача", style: TextStyle(fontSize: 24),),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomTextFuild(label: "Имя", hintText: "Иван", controller: viewModel.firstNameController, validator: Validator.validateName),
              CustomTextFuild(label: "Фамилия", hintText: "Иванов", controller: viewModel.lastNameController, validator: Validator.validateName),
              CustomTextFuild(label: "Email", hintText: "doctor@mail.com", controller: viewModel.emailController, validator: Validator.validateEmail),
              CustomTextFuild(label: "Пароль", hintText: "Введите пароль", controller: viewModel.passwordController, validator: Validator.validatePassword),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  onPressed: viewModel.isLoading ? null : () {
                    if (_formKey.currentState!.validate()) {
                      viewModel.createAccount(
                        onSuccess: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Врач создан! Теперь заполните профиль.")));
                          Navigator.pop(context);
                        },
                        onError: (msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg))),
                      );
                    }
                  },
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Создать аккаунт", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}