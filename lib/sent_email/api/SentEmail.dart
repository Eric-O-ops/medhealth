import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SentEmail {

  String email = "";
  String subject = "";
  String body = "";

  SentEmail setEmail(String value) {
    email = value;
    return this;
  }

  SentEmail setSubject(String value) {
    subject = value;
    return this;
  }

  SentEmail setBody(String value) {
    body = value;
    return this;
  }

  bool sent() {
    final smtpServer = SmtpServer (
      'localhost',
      port: 1025,
      ssl: false,
      allowInsecure: true,
    );

    final message = Message()
      ..from = Address('medhealth@gmail.com', 'Medhealth')
      ..recipients.add(email)
      ..subject = subject
      ..text = body;

    try {
      send(message, smtpServer);
      return true;

    } catch (e) {
      return false;

    }
  }

}