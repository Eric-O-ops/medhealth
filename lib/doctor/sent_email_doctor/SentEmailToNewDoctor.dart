import 'package:medhealth/sent_email/api/SentEmail.dart' show SentEmail, SentEmailHtml;
import 'package:medhealth/sent_email/generators/PossowrdGenerator.dart' show PasswordGenerator;

class SentEmailToNewDoctor extends SentEmail {
  final String initials;
  final String address_branch;
  final String email;

  SentEmailToNewDoctor({
    required this.initials,
    required this.address_branch,
    required this.email,
  }) {
    subject = _getSubject();
    body = _getBody();
  }

  String _getSubject() {
    return "Доступ к системе: $address_branch - Учетные данные для $initials";
  }

  String _getBody() {
    final String password = PasswordGenerator().generate();

    return '''
Уважаемый(-ая) $initials!

Поздравляем Вас с началом работы в качестве "Доктора" в нашей медицинской клинике, Medhealth! Ваш профиль успешно активирован в корпоративной системе филиала "$address_branch".

        ВАШИ УЧЕТНЫЕ ДАННЫЕ ДЛЯ ВХОДА

Система: Электронная медицинская карта (ЭМК) / Корпоративная система

Логин: $email
Временный Пароль: $password

❗ Важная информация:
* Смена пароля: При первом входе НЕЗАМЕДЛИТЕЛЬНО смените временный пароль на более надежный.
* Поддержка: Если возникнут проблемы с доступом, свяжитесь с IT-поддержкой.

Желаем успешного начала работы!

С уважением,
Medhealth
''';
  }
}