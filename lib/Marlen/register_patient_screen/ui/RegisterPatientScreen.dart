import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/common/BaseScreen.dart'; // Предполагаемый импорт BaseScreen
import 'package:medhealth/styles/app_colors.dart';
import 'package:medhealth/common/validator/TextFieldValidator.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/common/view/CustomTextFieldPassword.dart';

import 'RegisterPatientModel.dart'; // Импорт вашей ViewModel

// 1. StatefulWidget для экрана
class RegisterPatientScreen extends StatefulWidget {
  const RegisterPatientScreen({super.key});

  @override
  State<RegisterPatientScreen> createState() => _RegisterPatientScreenState();
}

// 2. State, наследующий BaseScreen и вашу модель
class _RegisterPatientScreenState
    extends BaseScreen<RegisterPatientScreen, RegisterPatientModel> {

  // Локальный ключ для управления валидацией формы
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, RegisterPatientModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, size: 28, color: Colors.black),
                ),
              ),
              SvgPicture.asset('assets/images/Logo.svg',  height: 110),
              const Text(
                "Создать аккаунт пациента",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              CustomTextFuild(
                label: 'Имя',
                hintText: 'Введите имя',
                validator: Validator.validateName,
                onChanged: (String? value) {
                  if (value != null) viewModel.firstName = value;
                },
              ),

              CustomTextFuild(
                label: 'Фамилия',
                hintText: 'Введите фамилию',
                validator: Validator.validateName,
                onChanged: (String? value) {
                  if (value != null) viewModel.lastName = value;
                },
              ),

              // Email
              CustomTextFuild(
                label: "Email",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => viewModel.email = v ?? '',
                validator: (v) => Validator.validateEmail(v),
              ),
              const SizedBox(height: 15),
              CustomTextFuild(
                label: 'Телефон',
                hintText: 'Введите телефон',
                keyboardType: TextInputType.phone,
                validator: Validator.validatePhoneNumber,
                onChanged: (String? value) {
                  if (value != null) viewModel.phone = value;
                },
              ),
              // Внутри _RegisterPatientScreenState.buildBody(), добавьте перед Address или Password:

              CustomTextFuild(
                label: 'Дата рождения',
                hintText: 'YYYY-MM-DD',
                keyboardType: TextInputType.datetime,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Введите дату рождения.'
                    : null,
                onChanged: (String? value) {
                  if (value != null) viewModel.dateOfBirth = value;
                },
              ),

              // Address
              CustomTextFuild(
                label: "Адрес",
                hintText: "Введите адрес",
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Пожалуйста, введите адрес.'
                    : null,
                onChanged: (String? value) {
                  if (value != null) viewModel.address = value;
                },
              ),
              const SizedBox(height: 15),

              // Password
              CustomTextFieldPassword(
                label: "Пароль",
                hintText: "Введите пароль",
                isObscure: viewModel.hiddenPassword,
                onTapSuffixIcon: viewModel.togglePassword,
                onChanged: (v) => viewModel.password = v ?? '',
                validator: (v) => Validator.validatePassword(v),
              ),
              CustomTextFieldPassword(
                label: "Подтвердите пароль", // Новая метка
                hintText: "Повторите пароль",
                isObscure: viewModel.hiddenPassword,
                // Используем тот же метод переключения видимости
                onTapSuffixIcon: viewModel.togglePassword,
                onChanged: (v) => viewModel.passwordUser = v ?? '', // Сохраняем во второе поле

                // КЛЮЧЕВОЙ МОМЕНТ: Валидатор сравнивает оба поля
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, подтвердите пароль.';
                  }
                  // Сравниваем с основным паролем из модели
                  if (value != viewModel.password) {
                    return 'Пароли не совпадают.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Register Button
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
                    // Используем _formKey для валидации всех полей
                    if (_formKey.currentState!.validate()) {
                      // Передаем ключ в модель для валидации
                      final ok = await viewModel.register(_formKey);

                      if (ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Регистрация успешна!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Возвращаемся на предыдущий экран (LoginScreen)
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Ошибка при регистрации"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },

                  child: const Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}