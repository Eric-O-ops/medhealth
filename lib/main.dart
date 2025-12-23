import 'package:flutter/material.dart';
import 'package:medhealth/Marlen/login_screen/ui/view/SplashScreen.dart';
import 'package:medhealth/Marlen/role/owner_main_screen/OwnerMainModel.dart';
import 'package:medhealth/Marlen/role/owner_main_screen/model/BranchesModel.dart';
import 'package:medhealth/Marlen/role/owner_main_screen/screens/BranchesScreen.dart';
import 'package:medhealth/fake_main/ui/FakeMain.dart';
import 'package:medhealth/recovery_password/ui/base/RecoveryPasswordModel.dart';
import 'package:medhealth/recovery_password/ui/base/RecoveryPasswordScreen.dart';
import 'package:provider/provider.dart';

import 'Marlen/helps_screens/HelpsScreen.dart';
import 'Marlen/register_patient_screen/ui/RegisterPatientModel.dart';
import 'Marlen/register_patient_screen/ui/RegisterPatientScreen.dart';
import 'Marlen/role/admin_main_screen/ui/AdminMainModel.dart';
import 'Marlen/role/admin_main_screen/ui/AdminMainScreen.dart';
import 'Marlen/role/doctor_main_screen/DoctorMainScreen.dart';
import 'Marlen/role/manager_main_screen/ManagerMainScreen.dart';
import 'Marlen/role/owner_main_screen/OwnerMainScreen.dart';
import 'Marlen/role/user_main/ui/UserMainModel.dart';
import 'Marlen/role/user_main/ui/UserMainScreen.dart';
import 'application_form/ui/ApplicationFormModel.dart';
import 'application_form/ui/ApplicationFormScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      // В файле main.dart
    routes: {
    // 1. Экраны ГЛАВНОГО МЕНЮ (предполагаем, что используют модели)
    '/ownerMain': (context) => ChangeNotifierProvider(
    create: (_) => OwnerMainModel(), // Используйте вашу модель для Owner
    child: OwnerMainScreen(),
    ),
    // '/doctorMain': (context) => ChangeNotifierProvider(
    // create: (_) => DoctorMainModel(), // Используйте вашу модель для Doctor
    // child: DoctorMainScreen(),
    // ),
    // '/managerMain': (context) => ChangeNotifierProvider(
    // create: (_) => ManagerMainModel(), // Используйте вашу модель для Manager
    // child: ManagerMainScreen(),
    // ),
    '/adminMain': (context) => ChangeNotifierProvider(
    create: (_) => AdminMainModel(), // Используйте вашу модель для Admin
    child: AdminMainScreen(),
    ),
    '/userMain': (context) => ChangeNotifierProvider(
    create: (_) => UserMainModel(), // Используйте вашу модель для User
    child: UserMainScreen(),
    ),
// 1. Маршрут для экрана Помощи
      '/helpsscreen': (context) => HelpsScreen(),
      '/applicationForm': (context) => ChangeNotifierProvider(
          create: (_) => ApplicationFormModel(),
          child: ApplicationFormScreen(),),

    '/recovery': (context) => ChangeNotifierProvider(
    create: (_) => RecoveryPasswordModel(),
    child: RecoveryPasswordScreen(),
    ),

    // 3. ЭКРАН РЕГИСТРАЦИИ (уже исправлено)
    '/registerPatient': (context) => ChangeNotifierProvider(
    create: (_) => RegisterPatientModel(),
    child: const RegisterPatientScreen(),
    ),
    },
      home: SplashScreen(
          // child: FakeMain()
      ),
    );
  }
}

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({super.key});

  @override
  _ScreenContainerState createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }

  Widget LoadingScreen() {
    return Scaffold(
      appBar: AppBar(title: Text('Загрузка')),
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget MainScreen() {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: getListBottomNavBarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> getListBottomNavBarItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),

      BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Рецептура'),

      BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Продукты'),
    ];
  }
}
