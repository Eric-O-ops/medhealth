import 'package:flutter/material.dart';
import 'package:medhealth/fake_main/ui/FakeMain.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SafeArea(
          child: FakeMain()
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
