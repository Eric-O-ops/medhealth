import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhealth/application_form/ui/success_screen/SuccessScreen.dart';
import 'package:medhealth/application_form/ui/view/CustomTextField.dart';
import 'package:medhealth/common/BaseScreen.dart';

import '../../styles/app_colors.dart';
import 'ApplicationFormModel.dart';

class ApplicationFormScreen extends StatefulWidget {
  @override
  _ApplicationFormScreenState createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends BaseScreen<ApplicationFormScreen , ApplicationFormModel> {

  @override
  Widget buildBody(BuildContext context, ApplicationFormModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/Logo.svg',
            width: 115,
            height: 77,
          ),

          SizedBox(height: 8),

          Text(
            'Заявка на добавление\n частной клиники в систему',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),

          SizedBox(height: 8),

          CustomTextFuild(
              label: 'Имя',
              hintText: 'Введите имя',
              onChanged: (String? value) {
                if (value != null) {
                  viewModel.firstName = value;
                }
              }
          ),

          CustomTextFuild(
              label: 'Фамилия',
              hintText: 'Введите фамилию',
              onChanged: (String? value) {
                if (value != null) {
                  viewModel.lastName = value;
                }
              }
          ),

          CustomTextFuild(
              label: 'Название клиники',
              hintText: 'Введите название клиники',
              onChanged: (String? value) {
                if (value != null) {
                  viewModel.nameClinic = value;
                }
              }
          ),

          CustomTextFuild(
              label: 'Email',
              hintText: 'Введите email',
              onChanged: (String? value) {
                if (value != null) {
                  viewModel.email = value;
                }
              }
          ),

          CustomTextFuild(
              label: 'Телефон',
              hintText: 'Введите телефон',
              onChanged: (String? value) {
                if (value != null) {
                  viewModel.phoneNumber = value;
                }
              }
          ),

          CustomTextFuild(
              label: 'Описание',
              hintText: 'Введите описание',
              maxLines: null,
              onChanged: (String? value) {
                if (value != null) {
                  viewModel.description = value;
                }
              }
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
                viewModel.sentApplicationForm(
                    onSuccess: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuccessScreen()),
                      );
                    },
                    onError: () {
                      print("error");
                    }
                );
              })
        ],
      )
    );

  }
}


