import 'package:flutter/material.dart';
import 'package:medhealth/Marlen/login_screen/ui/view/SplashScreen.dart';
import 'package:medhealth/Marlen/role/owner_main_screen/OwnerMainModel.dart';
import 'package:medhealth/patient_appointment/dashboard/ui/PatientDashboardScreen.dart';
import 'package:medhealth/patient_appointment/dashboard/ui/PatientDashboardScreenModel.dart';
import 'package:medhealth/recovery_password/ui/base/RecoveryPasswordModel.dart';
import 'package:medhealth/recovery_password/ui/base/RecoveryPasswordScreen.dart';
import 'package:provider/provider.dart';
import 'Marlen/helps_screens/HelpsScreen.dart';
import 'Marlen/register_patient_screen/ui/RegisterPatientModel.dart';
import 'Marlen/register_patient_screen/ui/RegisterPatientScreen.dart';
import 'Marlen/role/admin_main_screen/ui/AdminMainModel.dart';
import 'Marlen/role/admin_main_screen/ui/AdminMainScreen.dart';
import 'Marlen/role/manager_main_screen/ui/ManagerMainModel.dart';
import 'Marlen/role/manager_main_screen/ui/ManagerMainScreen.dart';
import 'Marlen/role/owner_main_screen/OwnerMainScreen.dart';
import 'Marlen/role/user_main/ui/UserMainModel.dart';
import 'Marlen/role/user_main/ui/UserMainScreen.dart';
import 'application_form/ui/ApplicationFormModel.dart';
import 'application_form/ui/ApplicationFormScreen.dart';

import 'common/RAM.dart';
import 'http/HttpRequest.dart';

void main() {
  setUpDioHttpRequest();
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
    '/ownerMain': (context) => ChangeNotifierProvider(
    create: (_) => OwnerMainModel(),
    child: OwnerMainScreen(),
    ),
      '/managerMain': (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        final int actualId = (args is int) ? args : 0;

        return ChangeNotifierProvider(
          create: (_) => ManagerMainModel(),
          child: ManagerMainScreen(),
        );
      },
    '/adminMain': (context) => ChangeNotifierProvider(
    create: (_) => AdminMainModel(),
    child: AdminMainScreen(),
    ),
    '/userMain': (context) => ChangeNotifierProvider(
    create: (_) => UserMainModel(),
    child: UserMainScreen(),
    ),
      '/helpsscreen': (context) => HelpsScreen(),
      '/applicationForm': (context) => ChangeNotifierProvider(
          create: (_) => ApplicationFormModel(),
          child: ApplicationFormScreen(),),

    '/recovery': (context) => ChangeNotifierProvider(
    create: (_) => RecoveryPasswordModel(),
    child: RecoveryPasswordScreen(),
    ),

    '/registerPatient': (context) => ChangeNotifierProvider(
    create: (_) => RegisterPatientModel(),
    child: const RegisterPatientScreen(),
    ),

    '/patientDashboard': (context) => ChangeNotifierProvider(
      create: (_) => PatientDashboardScreenModel(idDoctor: Ram().getDoctorId()),
      child: PatientDashboardScreen(),
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
