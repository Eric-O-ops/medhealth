import 'package:flutter/material.dart';
class Usermainscreen extends StatefulWidget {
  const Usermainscreen({super.key});

  @override
  State<Usermainscreen> createState() => _UsermainscreenState();
}

class _UsermainscreenState extends State<Usermainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Экран обычного пользователя(пациент)")
        ],
      ),
    );
  }
}
