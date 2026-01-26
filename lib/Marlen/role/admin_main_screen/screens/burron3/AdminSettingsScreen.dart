import 'package:flutter/material.dart';
import 'package:medhealth/Marlen/role/admin_main_screen/screens/burron3/AddAdminModel.dart';
import 'package:medhealth/Marlen/role/admin_main_screen/screens/burron3/ManualAddClinicModel.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../login_screen/ui/LoginFormModel.dart';
import '../../../../login_screen/ui/LoginFormScreen.dart';
import 'AddAdminScreen.dart';
import 'ManualAddClinicScreen.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Управление системой",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),

          _buildMenuButton(
            context,
            title: "Добавить администратора",
            subtitle: "Создать дочернего админа",
            icon: Icons.admin_panel_settings,
            color: AppColors.blue,
            onTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (_) => AddAdminModel(),
                  child: AddAdminScreen(),
                ),),
            ),
          ),

          const SizedBox(height: 15),

          _buildMenuButton(
            context,
            title: "Добавить клинику",
            subtitle: "Ручное создание владельца и клиники",
            icon: Icons.local_hospital,
            color: Colors.green.shade700,
            onTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (_) => ManualAddClinicModel(),
                  child: ManualAddClinicScreen(),
                ),
              ),
            ),
          ),
          Center(
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => LoginFormModel(),
                      child: const LoginScreen(),
                    ),
                  ),
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text("Выйти из аккаунта", style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}