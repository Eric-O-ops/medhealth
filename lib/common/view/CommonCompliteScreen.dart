import 'package:flutter/material.dart';
import 'package:medhealth/Marlen/login_screen/ui/LoginFormScreen.dart';
import 'package:medhealth/fake_main/ui/FakeMain.dart';
import 'package:provider/provider.dart';
import '../../../styles/app_colors.dart';
import '../../Marlen/login_screen/ui/LoginFormModel.dart';

class CommonCompleteScreen extends StatelessWidget {

  final String title;

  const CommonCompleteScreen({super.key, required this.title});

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
              title,
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider<LoginFormModel>(
                            create: (_) => LoginFormModel(),
                            child: const LoginScreen())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
