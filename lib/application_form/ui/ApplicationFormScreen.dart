import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/common/view/CommonCompliteScreen.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/common/BaseScreen.dart';

import '../../common/validator/TextFieldValidator.dart';
import '../../styles/app_colors.dart';
import 'ApplicationFormModel.dart';

class ApplicationFormScreen extends StatefulWidget {
  @override
  _ApplicationFormScreenState createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState
    extends BaseScreen<ApplicationFormScreen, ApplicationFormModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, ApplicationFormModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                iconSize: 28,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SvgPicture.asset('assets/images/Logo.svg', height: 110),

            SizedBox(height: 8),

            Text(
              'Заявка на добавление\n частной клиники в систему',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),

            SizedBox(height: 20),

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

            CustomTextFuild(
              label: 'Название клиники',
              hintText: 'Введите название клиники',
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Поле обязательно.' : null,
              onChanged: (String? value) {
                if (value != null) viewModel.nameClinic = value;
              },
            ),

            CustomTextFuild(
              label: 'Email',
              hintText: 'Введите email',
              keyboardType: TextInputType.emailAddress,
              validator: Validator.validateEmail,
              onChanged: (String? value) {
                if (value != null) viewModel.email = value;
              },
            ),

            CustomTextFuild(
              label: 'Телефон',
              hintText: 'Введите телефон',
              keyboardType: TextInputType.phone,
              validator: Validator.validatePhoneNumber,
              onChanged: (String? value) {
                if (value != null) viewModel.phoneNumber = value;
              },
            ),

            CustomTextFuild(
              label: 'Описание',
              hintText: 'Введите описание',
              maxLines: null,
              keyboardType: TextInputType.multiline,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Пожалуйста, введите описание.'
                  : null,
              onChanged: (String? value) {
                if (value != null) viewModel.description = value;
              },
            ),

            SizedBox(height: 8),

            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.blue,
              child: const Text(
                'Отправить завявку на рассмотрение',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  viewModel.sentApplicationForm(
                    onSuccess: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommonCompleteScreen(title: "Заявка успешно отправлена!"),
                        ),
                      );
                    },
                    onError: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ошибка отправки заявки.'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
