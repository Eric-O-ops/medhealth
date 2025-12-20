import 'dart:math';

class OTPCodeGenerator {

  static String generateOTP() {
    final Random random = Random();

    final int otpNumber = random.nextInt(10000);

    final String otp = otpNumber.toString().padLeft(4, '0');

    return otp;
  }
}