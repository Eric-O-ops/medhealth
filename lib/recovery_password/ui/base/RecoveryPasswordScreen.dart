import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/recovery_password/ui/otp/OTPModel.dart';
import 'package:medhealth/recovery_password/ui/otp/OTPScreen.dart';

import '../../../common/BaseScreen.dart';
import '../../../common/validator/TextFieldValidator.dart';
import '../../../common/view/CustomTextField.dart';
import '../../../styles/app_colors.dart';
import 'RecoveryPasswordModel.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  @override
  _RecoveryPasswordScreenState createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState
    extends BaseScreen<RecoveryPasswordScreen, RecoveryPasswordModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, RecoveryPasswordModel viewModel) {
    return Form(
      key: _formKey,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: AppColors.blue,
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SvgPicture.asset('assets/images/Logo.svg',  height: 110),

          SizedBox(height: 8),

          Text(
            'Восстановление пароля',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),

          SizedBox(height: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFuild(
                label: 'Email',
                hintText: 'Введите email',
                keyboardType: TextInputType.emailAddress,
                validator: Validator.validateEmail,
                onChanged: (String? value) {
                  if (value != null) viewModel.email = value;
                },
              ),

              viewModel.isError ? Padding(
                padding: EdgeInsetsGeometry.only(left: 20),
                child: Text(
                  'Пользователь не зарегистриррован',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ) : SizedBox(height: 0),

              viewModel.isError ? SizedBox(height: 10) : SizedBox(height: 0),
            ],
          ),

          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.blue,
            child: (viewModel.isLoading)
                ? CircularProgressIndicator()
                : Text(
                    'Продолжить',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                viewModel.sentRecoveryPassword(
                  onSuccess: () {
                    navigateTo(
                        screen: OTPScreen(),
                        createModel: () => OTPModel(email: viewModel.email)
                    );
                  },
                  onError: () {
                      //todo add error massage
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
