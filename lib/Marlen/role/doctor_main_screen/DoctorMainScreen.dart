import 'package:flutter/material.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({super.key});

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Экран Доктара",style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
}
