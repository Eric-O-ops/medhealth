import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:medhealth/recovery_password/rep/RecoveryPasswordRep.dart';
import 'package:medhealth/sent_email/generators/OTPCodeGenerator.dart';

import '../../../sent_email/api/SentEmail.dart';

class OTPModel extends BaseScreenModel {
  final String email;
  final rep = RecoveryPasswordRep();
  late String otpCode;

  OTPModel({required this.email});

  bool _isSentCodeAgain = false;

  bool get isSentCodeAgain => _isSentCodeAgain;
  set isSentCodeAgain(bool value) {
    _isSentCodeAgain = value;
    notifyListeners();
  }

  @override
  Future<void> onInitialization() async {

    otpCode = OTPCodeGenerator.generateOTP();

    SentEmail()
    .setEmail(email)
    .setSubject('Код для восстановления пароля')
    .setBody('Никому не показывайте код: $otpCode')
    .sent();

  }

  void checkOtpCode(String currentOtpCode, Function() success) {
    if(otpCode == currentOtpCode) {
      isError = false;
      success();
    } else {
      isError = true;
    }

  }

  void sentCodeAgain() {
    otpCode = OTPCodeGenerator.generateOTP();

    SentEmail()
    .setEmail(email)
    .setSubject('Код для восстановления пароля')
    .setBody('Никому не показывайте код: $otpCode')
    .sent();

    isSentCodeAgain = false;
  }

}

