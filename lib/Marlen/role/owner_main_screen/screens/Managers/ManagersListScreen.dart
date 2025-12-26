import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../OwnerMainModel.dart';
import 'EditManagerScreen.dart';

class ManagersListScreen extends StatefulWidget {
  const ManagersListScreen({super.key});

  @override
  State<ManagersListScreen> createState() => _ManagersListScreenState();
}

class _ManagersListScreenState extends State<ManagersListScreen> {
  @override
  void initState() {
    super.initState();
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
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Менеджеры",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16),
                  children: [
                    const TextSpan(
                      text: "Количество: ",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: viewModel.managers.length.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () => viewModel.loadManagers(),
        child: viewModel.managers.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          itemCount: viewModel.managers.length,
          itemBuilder: (context, index) {
            final manager = viewModel.managers[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: Card(
                color: AppColors.gray,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.blue.withOpacity(0.1),
                    child: const Icon(Icons.person, color: AppColors.blue),
                  ),
                  title: Text(
                    "${manager.firstName} ${manager.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Email: ${manager.email}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EditManagerScreen(manager: manager)),
                          );

                          if (result != null && result is Map<String, dynamic>) {
                            // Теперь обращаемся к userId, который мы добавили в DTO
                            viewModel.updateManager(manager.userId, result);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirm(context, viewModel, manager);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Метод подтверждения удаления
  void _showDeleteConfirm(BuildContext context, OwnerMainModel viewModel, dynamic manager) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удалить менеджера?"),
        content: Text("Это действие удалит доступ для ${manager.firstName}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Отмена"),
          ),
          TextButton(
          onPressed: () {
    // Передаем userId для удаления из БД и manager.id для удаления из списка Flutter
    viewModel.deleteManager(manager.userId, manager.id);
    Navigator.pop(ctx);
    },
    child: const Text("Удалить", style: TextStyle(color: Colors.red)),
    ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        Center(
          child: Column(
            children: [
              Icon(Icons.group_off_outlined, size: 80, color: Colors.grey.shade300),
              const SizedBox(height: 10),
              const Text("Менеджеры не найдены", style: TextStyle(color: Colors.grey)),
              const Text(
                "Попробуйте потянуть вниз для обновления",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}