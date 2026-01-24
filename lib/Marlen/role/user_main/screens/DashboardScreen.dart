import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../styles/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("MedHealth", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Добро пожаловать!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Выберите нужный раздел:",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Сетка кнопок в стиле Владельца/Менеджера
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 колонки
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: "Все клиники",
                    subtitle: "Поиск медучреждений",
                    icon: Icons.local_hospital_outlined,
                    color: AppColors.blue,
                    onTap: () {
                      // Сюда добавим переход к списку клиник
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: "Мои записи",
                    subtitle: "Ближайшие приемы",
                    icon: Icons.event_note_outlined,
                    color: Colors.green,
                    onTap: () {
                      // Переход к вкладке "Записи"
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: "История",
                    subtitle: "Прошлые визиты",
                    icon: Icons.history_edu_outlined,
                    color: Colors.orange,
                    onTap: () {
                      // Переход к вкладке "История"
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: "Профиль",
                    subtitle: "Личные данные",
                    icon: Icons.manage_accounts_outlined,
                    color: Colors.purple,
                    onTap: () {
                      // Переход к вкладке "Профиль"
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод для создания карточки (дизайн как у владельца)
  Widget _buildMenuCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}