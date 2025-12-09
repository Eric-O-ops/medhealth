import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart'; // Ваш BaseScreen
import 'package:medhealth/styles/app_colors.dart'; // Ваши цвета
import 'UserMainModel.dart';

// ----------------------------------------------------
// ВАЖНО: Создайте заглушки для контента вкладок
// ----------------------------------------------------
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("Главная", style: TextStyle(fontSize: 24)));
}
class AppointmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("Записи", style: TextStyle(fontSize: 24)));
}
class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("История", style: TextStyle(fontSize: 24)));
}
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("Профиль", style: TextStyle(fontSize: 24)));
}
// ----------------------------------------------------


class UserMainScreen extends StatefulWidget {
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState
    extends BaseScreen<UserMainScreen, UserMainModel> {

  // Список виджетов, соответствующих вкладкам
  final List<Widget> _screens = [
    DashboardScreen(),      // 0: Главная
    AppointmentsScreen(),   // 1: Записи
    HistoryScreen(),        // 2: История
    ProfileScreen(),        // 3: Профиль
  ];

  @override
  Widget buildBody(BuildContext context, UserMainModel viewModel) {
    return Scaffold(
      // 1. Отображение контента в зависимости от выбранного индекса
      body: IndexedStack(
        index: viewModel.selectedIndex,
        children: _screens,
      ),

      // 2. Нижняя панель навигации (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Чтобы все 4 иконки были видны
        currentIndex: viewModel.selectedIndex,
        selectedItemColor: AppColors.blue, // Используйте ваш основной цвет
        unselectedItemColor: Colors.grey,

        // Обработка нажатия: обновляем индекс в модели
        onTap: (index) => viewModel.setTabIndex(index),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Записи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'История',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}