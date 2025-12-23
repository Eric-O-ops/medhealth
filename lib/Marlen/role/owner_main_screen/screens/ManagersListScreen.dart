import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../OwnerMainModel.dart';

class ManagersListScreen extends StatefulWidget {
  const ManagersListScreen({super.key});

  @override
  State<ManagersListScreen> createState() => _ManagersListScreenState();
}

class _ManagersListScreenState extends State<ManagersListScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем данные сразу при инициализации экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OwnerMainModel>().loadManagers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OwnerMainModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Менеджеры", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Кнопка принудительного обновления
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.blue),
            onPressed: () => viewModel.loadManagers(),
          )
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () => viewModel.loadManagers(),
        child: viewModel.managers.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: viewModel.managers.length,
          itemBuilder: (context, index) {
            final manager = viewModel.managers[index];
            return Card(
              color: AppColors.gray,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.blue.withOpacity(0.1),
                  child: const Icon(Icons.person, color: AppColors.blue),
                ),
                title: Text("${manager.firstName} ${manager.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                // Выводим телефон и почту
                subtitle: Text("Email: ${manager.email}\n}"),
                isThreeLine: true,
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => viewModel.deleteManager(manager.id),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView( // Используем ListView чтобы работал RefreshIndicator
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        Center(
          child: Column(
            children: [
              Icon(Icons.group_off_outlined, size: 80, color: Colors.grey.shade300),
              const SizedBox(height: 10),
              const Text("Менеджеры не найдены", style: TextStyle(color: Colors.grey)),
              const Text("Попробуйте потянуть вниз для обновления", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}