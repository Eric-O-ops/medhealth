import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/recovery_password/ui/change_password/ChangePasswordModel.dart';
import 'package:medhealth/recovery_password/ui/view/SuccessPasswordChangedScreen.dart';

import '../../../common/validator/TextFieldValidator.dart';
import '../../../common/view/CustomTextFieldPassword.dart';
import '../../../styles/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState
    extends BaseScreen<ChangePasswordScreen, ChangePasswordModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, ChangePasswordModel viewModel) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/Logo.svg', width: 115, height: 77),

          SizedBox(height: 8),

          Text(
            'Введите новый пароль',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),

          SizedBox(height: 32),

          CustomTextFieldPassword(
            label: 'Новый пароль',
            hintText: 'Введите новый пароль',
            validator: (value) => Validator.validatePassword(value),
            isObscure: viewModel.isObscurePassword,
            onTapSuffixIcon: () {
              viewModel.isObscurePassword = !viewModel.isObscurePassword;
            },
            onChanged: (String? value) {
              if (value != null) viewModel.password = value;
            },
          ),

          SizedBox(height: 8),

          CustomTextFieldPassword(
            label: 'Повторите пароль',
            hintText: 'Повторите пароль',
            validator: (value) =>
                Validator.validateRepeatPassword(viewModel.password, value),
            isObscure: viewModel.isObscureRepeatPassword,
            onTapSuffixIcon: () {
              viewModel.isObscureRepeatPassword =
                  !viewModel.isObscureRepeatPassword;
            },
            onChanged: (String? value) {},
          ),

          SizedBox(height: 32),

          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.blue,
            child: const Text(
              'Изменить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                  viewModel.changePassword((){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SuccessPasswordChangedScreen()),
                            (Route<dynamic> route) => false
                    );
                  });
              }
            },
          ),
        ],
      ),
    );
  }
}
