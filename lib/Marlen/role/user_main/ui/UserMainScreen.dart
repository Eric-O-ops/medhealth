import 'package:flutter/material.dart';
import 'package:medhealth/Marlen/role/user_main/models/MyAppointmentsModel.dart';
import 'package:medhealth/Marlen/role/user_main/screens/ClinicsListScreen.dart';
import 'package:medhealth/Marlen/role/user_main/screens/MyAppointmentsScreen.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../models/ClinicListModel.dart';
import '../models/PatientProfileModel.dart';
import '../screens/PatientProfileScreen.dart';
import 'UserMainModel.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends BaseScreen<UserMainScreen, UserMainModel> {
  late List<Widget> _screens;
  late ClinicListModel _clinicListModel;

  // Внутри _UserMainScreenState
  @override
  void initState() {
    super.initState();
    _clinicListModel = ClinicListModel();

    _screens = [
      ChangeNotifierProvider.value(
        value: _clinicListModel,
        child: const ClinicsListScreen(),
      ),
      ChangeNotifierProvider(
        create: (_) => MyAppointmentsModel(),
        child: const MyAppointmentsScreen(),
      ),
      const Center(child: Text("История")),

      // Вкладка Профиля
      ChangeNotifierProvider(
        create: (_) => PatientProfileModel(),
        child: const PatientProfileScreen(),//горит красным
      ),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clinicListModel.loadClinics();
    });
  }

  Widget _buildNavItem({required IconData icon, required bool isSelected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.blue.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: isSelected ? Colors.white : AppColors.blue, size: 32),
    );
  }

  @override
  Widget buildBody(BuildContext context, UserMainModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.wight,
      body: IndexedStack(
        index: viewModel.selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(30),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navButton(0, Icons.local_hospital_outlined, viewModel),
                _navButton(1, Icons.calendar_month_outlined, viewModel),
                _navButton(2, Icons.history_outlined, viewModel),
                _navButton(3, Icons.person_outline, viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButton(int index, IconData icon, UserMainModel viewModel) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => viewModel.setTabIndex(index),
      child: _buildNavItem(icon: icon, isSelected: viewModel.selectedIndex == index),
    );
  }
}