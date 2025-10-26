import 'dart:math';

class PasswordGenerator {

  String generate() {
    const int passwordLength = 8;

    const String lowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const String upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String special = '!@#\$%^&*()-_+=';

    const String allChars = lowerCase + upperCase + numbers + special;

    final Random random = Random.secure();
    final StringBuffer password = StringBuffer();

    password.write(lowerCase[random.nextInt(lowerCase.length)]);
    password.write(upperCase[random.nextInt(upperCase.length)]);
    password.write(numbers[random.nextInt(numbers.length)]);
    password.write(special[random.nextInt(special.length)]);

    for (int i = 0; i < passwordLength - 4; i++) {
      password.write(allChars[random.nextInt(allChars.length)]);
    }

    List<String> chars = password.toString().split('');
    chars.shuffle(random);

    return chars.join();
  }

}