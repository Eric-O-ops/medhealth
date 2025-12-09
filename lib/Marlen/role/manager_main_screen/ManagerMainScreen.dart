import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medhealth/Marlen/login_screen/ui/LoginFormScreen.dart';

class ManagerMainScreen extends StatefulWidget {
  const ManagerMainScreen({super.key});

  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends State<ManagerMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Экран Манеджера",style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
}
