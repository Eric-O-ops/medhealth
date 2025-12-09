import 'package:flutter/material.dart';
class OwnerMainScreen extends StatefulWidget {
  const OwnerMainScreen({super.key});

  @override
  State<OwnerMainScreen> createState() => _OwnerMainScreenState();
}

class _OwnerMainScreenState extends State<OwnerMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Экран владельца")
        ],
      ),
    );
  }
}
