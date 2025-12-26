import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medhealth/Marlen/login_screen/ui/LoginFormScreen.dart';
import 'package:medhealth/Marlen/role/admin_main_screen/ui/AdminMainModel.dart';
import 'package:medhealth/Marlen/role/owner_main_screen/OwnerMainModel.dart';
import 'package:medhealth/Marlen/role/owner_main_screen/OwnerMainScreen.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../role/admin_main_screen/ui/AdminMainScreen.dart';
import '../LoginFormModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 1),
          () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<LoginFormModel>(
              create: (_) => LoginFormModel(),
              child: const LoginScreen(),)//пока закоментировал чтобы сразу переходит на экран админа и там работать
            // builder: (_)=> ChangeNotifierProvider<OwnerMainModel>(
            //   create: (_)=>OwnerMainModel(),
            //   child: const OwnerMainScreen(),
            // ),
          ),
        );
      },
    );
  }

  // ⚠️ Вот здесь должен быть build, не внутри initState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/Logo.svg',
              width: 162,
              height: 102,
            ),
            const SizedBox(height: 10),
            Text(
              'Поиск и запись',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 40),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
