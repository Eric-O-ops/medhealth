import 'package:flutter/material.dart';
class Ownermainscreen extends StatefulWidget {
  const Ownermainscreen({super.key});

  @override
  State<Ownermainscreen> createState() => _OwnermainscreenState();
}

class _OwnermainscreenState extends State<Ownermainscreen> {
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
