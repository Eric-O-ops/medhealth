import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
        // можно оставить пустым
import '../screens/burron3/AdminSettingsScreen.dart';
import '../screens/button 1/UserManagementScreen.dart';
import '../screens/button 2/ClinicRequestsScreen.dart';
import '../ui/AdminMainModel.dart';           // твой модель (AdminMainModel)

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends BaseScreen<AdminMainScreen, AdminMainModel> {
  final List<Widget> _screens = const [
    UserManagementScreen(),
    ClinicRequestsScreen(),
    AdminSettingsScreen(),

  ];

  Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
    int? badgeCount,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
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
        ),
        if (badgeCount != null && badgeCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Text(
                badgeCount > 99 ? '99+' : '$badgeCount',
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, AdminMainModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.wight,
      body: IndexedStack(
        index: viewModel.selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
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
                // Пользователи
                GestureDetector(
                  onTap: () => viewModel.setTabIndex(0),
                  child: _buildNavItem(icon: Icons.people_outline, isSelected: viewModel.selectedIndex == 0),
                ),
                // Заявки + бейдж
                GestureDetector(
                  onTap: () => viewModel.setTabIndex(1),
                  child: _buildNavItem(
                    icon: Icons.assignment_outlined,
                    isSelected: viewModel.selectedIndex == 1,
                    badgeCount: viewModel.pendingRequestsCount > 0 ? viewModel.pendingRequestsCount : null,
                  ),
                ),
                // Добавить / Настройки
                GestureDetector(
                  onTap: () => viewModel.setTabIndex(2),
                  child: _buildNavItem(icon: Icons.add, isSelected: viewModel.selectedIndex == 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}