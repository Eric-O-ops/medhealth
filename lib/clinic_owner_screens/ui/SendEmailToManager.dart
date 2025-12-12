import 'package:medhealth/sent_email/api/SentEmail.dart';
import 'package:medhealth/sent_email/generators/PossowrdGenerator.dart';

class SendEmailToManager extends SentEmail {
  final String initials;
  final address_branch;
  final email;

  SendEmailToManager({
    required this.initials,
    required this.address_branch,
    required this.email,
  }) {
    subject = _getSubject();
    body = _getBody();
  }

  String _getSubject() {
    return "Доступ к системе: $address_branch – Менеджер (или) Уведомление о добавлении в филиал – $initials";
  }

  String _getBody() {
    final password = PasswordGenerator();

    return '''
Уважаемый(-ая) $initials!

Поздравляем Вас с началом работы в качестве "Менеджера" в нашей медицинской клинике, Medhealth.

Информируем Вас, что Ваш профиль был успешно добавлен и активирован в нашей корпоративной системе для работы филиалом «$address_branch».

С этого момента Вы имеете полный доступ ко всем необходимым ресурсам и инструментам для управления данным филиалом.

Ваши учетные данные и инструкции по первому входу были отправлены отдельным сообщением/предоставлены HR-отделом.

Используйте следующий данные для входна:

логин: $email
пароль: $password

С уважением,

Medhealth
  ''';
  }
}