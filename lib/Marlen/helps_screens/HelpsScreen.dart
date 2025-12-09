import 'package:flutter/material.dart';
import 'package:medhealth/styles/app_colors.dart';

class HelpsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Помощь'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),

              // Кнопка для перехода на форму заявки
              ListTile(
                title: const Text(
                  "Подать заявку на добавление частной клиники",
                  style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,        // подчёркивание
                    decorationColor: AppColors.blue,              // цвет подчёркивания
                    decorationThickness: 1,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.blue),
                onTap: () {
                  // Переход на экран заявки, который мы зарегистрируем в main.dart
                  Navigator.pushNamed(context, '/applicationForm');
                },
                contentPadding: EdgeInsets.zero,
              ),

              const Divider(),
              Text(
                "Как войти управляещему",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,        // подчёркивание
                  decorationColor: AppColors.blue,              // цвет подчёркивания
                  decorationThickness: 1,
                ),
              ),
              const Divider(),
        Text(
        "Как войти врачу",
        style: TextStyle(
          fontSize: 16,
        color: AppColors.blue,
        fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,        // подчёркивание
          decorationColor: AppColors.blue,              // цвет подчёркивания
          decorationThickness: 1,
        ),
      ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}