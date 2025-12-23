import 'package:flutter/material.dart';
import 'package:medhealth/styles/app_colors.dart';
import 'package:provider/provider.dart';
// Импортируй созданные ранее экраны создания
import '../model/AddManagerModel.dart';
import '../model/CreateBranchModel.dart';
import 'CreateBranchScreen.dart';
import 'AddManagerScreen.dart';

class OwnerToolsScreen extends StatelessWidget {
  const OwnerToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Добавление", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildBigButton(
              context,
              title: "Добавить филиал",
              subtitle: "Создайте новую точку вашей сети",
              icon: Icons.storefront_outlined,
              color: AppColors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => CreateBranchModel(),
                    child: const CreateBranchScreen(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildBigButton(
              context,
              title: "Добавить менеджера",
              subtitle: "Зарегистрируйте сотрудника для филиала",
              icon: Icons.person_add_alt_1_outlined,
              color: Colors.green.shade600,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => AddManagerModel(),
                    child: const AddManagerScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, {
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
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}