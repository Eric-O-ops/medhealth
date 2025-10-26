import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/recovery_password/ui/change_password/ChangePasswordModel.dart';
import 'package:medhealth/recovery_password/ui/change_password/ChangePasswordScreen.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../view/SuccessPasswordChangedScreen.dart';
import 'OTPModel.dart';

class OTPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OTPScreenState();
  }
}

class _OTPScreenState extends BaseScreen<OTPScreen, OTPModel> {
  @override
  Widget buildBody(BuildContext context, OTPModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/Logo.svg', width: 115, height: 77),

        SizedBox(height: 8),

        Text(
          'Мы отправили код\n на вашу почту.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),

        Text(
          'Введите секретный код из письма',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),

        SizedBox(height: 20),

        OtpTextField(
          numberOfFields: 4,
          showFieldAsBox: true,
          fieldWidth: 64,
          fieldHeight: 64,
          focusedBorderColor: (viewModel.isError) ? Colors.red : AppColors.blue,
          borderColor: (viewModel.isError) ? Colors.red : AppColors.lightBlue,
          enabledBorderColor: (viewModel.isError)
              ? Colors.red.shade200
              : AppColors.lightBlue,
          onSubmit: (String verificationCode) {
            viewModel.checkOtpCode(verificationCode, () {
              navigateTo(
                screen: ChangePasswordScreen(),
                createModel: () => ChangePasswordModel(viewModel.email),
              );
            });
          },
        ),

        (viewModel.isSentCodeAgain)
            ? TextButton(
                onPressed: () {
                  viewModel.sentCodeAgain();
                },
                child: Text(
                  'Отправить код снова',
                  style: TextStyle(fontSize: 12, color: AppColors.blue),
                ),
              )
            : Countdown(
                seconds: 50,
                build: (BuildContext context, double time) => Text(
                  'Отправить снова снова чрез: ${time.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12),
                ),
                interval: const Duration(seconds: 1),
                onFinished: () {
                  viewModel.isSentCodeAgain = true;
                },
              ),
      ],
    );
  }
}
