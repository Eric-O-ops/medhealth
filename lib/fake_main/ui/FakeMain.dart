import 'package:flutter/material.dart';
import 'package:medhealth/application_form/ui/ApplicationFormModel.dart';
import 'package:medhealth/application_form/ui/ApplicationFormScreen.dart';
import 'package:medhealth/sent_email/api/SentEmail.dart';
import 'package:provider/provider.dart';
import '../../sent_email/generators/PossowrdGenerator.dart';
import '../../styles/app_colors.dart';

class FakeMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.blue,
            child: const Text(
              'Отправить заявку',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider<ApplicationFormModel>( // ⬅️ Оборачиваем здесь
                    create: (context) => ApplicationFormModel(),
                    child: ApplicationFormScreen(),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 20,),

          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.blue,
            child: const Text(
              'Подтвердить заявку',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            onPressed: () {
              SentEmail(
                  email: "theslyfox43@gmail.com",
                  subject: "Ответ на заявку.",
                  body: "login: theslyfox43@gmail.com\n"
                      "password: ${PasswordGenerator().generate()}")
              .sent();
            },
          )

        ],
      ),
    );
  }

}