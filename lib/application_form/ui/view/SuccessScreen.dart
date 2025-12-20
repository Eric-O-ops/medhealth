import 'package:flutter/material.dart';
import 'package:medhealth/fake_main/ui/FakeMain.dart';
import '../../../styles/app_colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/success.png',
              width: 167,
              height: 167,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 20),

            Text(
              "Заявка была успешно отправлена !",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),

            SizedBox(height: 40),

            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.blue,
              child: const Text(
                'Продолжить',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FakeMain()),
                        (Route<dynamic> route) => false
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
