import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SentEmail {

  final String email;
  final String subject;
  final String body;

  SentEmail({required this.email, required this.subject, required this.body});

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