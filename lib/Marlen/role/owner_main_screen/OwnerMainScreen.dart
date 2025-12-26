import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/styles/app_colors.dart';

import 'OwnerMainModel.dart';
import 'screens/Branches/BranchesScreen.dart';
import 'screens/Managers/ManagersListScreen.dart';
import 'screens/OwnerToolsScreen.dart';
import 'screens/HolidaySettingsScreen.dart';

import 'model/BranchesModel.dart';
import 'model/HolidaySettingsModel.dart';

class OwnerMainScreen extends StatefulWidget {
  const OwnerMainScreen({super.key});

  @override
  State<OwnerMainScreen> createState() => _OwnerMainScreenState();
}

class _OwnerMainScreenState extends BaseScreen<OwnerMainScreen, OwnerMainModel> {
  late List<Widget> _screens;
  late BranchesModel branchesModel;
  late HolidaySettingsModel holidayModel;

  @override
  void initState() {
    super.initState();
    // Создаем модель филиалов
    branchesModel = BranchesModel();
    holidayModel = HolidaySettingsModel();

    _screens = [
      ChangeNotifierProvider.value(
        value: branchesModel, // Используем нашу переменную
        child: const BranchesScreen(),
      ),
      const ManagersListScreen(),
      const OwnerToolsScreen(),
      ChangeNotifierProvider.value(
          value: holidayModel,
          child: const HolidaySettingsScreen()), // Используем её
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        // 1. Настраиваем главную модель (для менеджеров и табов)
        Provider.of<OwnerMainModel>(context, listen: false).setupOwner(args);

        // 2. Настраиваем модель филиалов
        branchesModel.updateOwnerId(args);
        holidayModel.updateOwnerId(args);
      }
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
  Widget buildBody(BuildContext context, OwnerMainModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.wight, // Проверь название: обычно white, а не wight
      body: IndexedStack(
        index: viewModel.selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius:  BorderRadius.circular(30),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navButton(0, Icons.location_city_outlined, viewModel),
                _navButton(1, Icons.people_outline, viewModel),
                _navButton(2, Icons.add, viewModel),
                _navButton(3, Icons.settings_outlined, viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButton(int index, IconData icon, OwnerMainModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.setTabIndex(index),
      child: _buildNavItem(icon: icon, isSelected: viewModel.selectedIndex == index),
    );
  }
}