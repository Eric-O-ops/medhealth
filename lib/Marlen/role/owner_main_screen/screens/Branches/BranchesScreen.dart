import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../styles/app_colors.dart';
import '../../OwnerMainModel.dart';
import '../../dto/BranchDto.dart';
import '../../model/BranchesModel.dart';
import '../../model/EditBranchModel.dart';
import 'EditBranchScreen.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BranchesModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(alignment: Alignment.centerLeft,
          child: const Text(
            "Мои филиалы",
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
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: viewModel.branches.length.toString(),
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
          : viewModel.branches.isEmpty
          ? const Center(child: Text("Филиалы не добавлены"))
          : RefreshIndicator(
        onRefresh: () => viewModel.loadBranches(),
        child: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: viewModel.branches.length,
          itemBuilder: (context, index) {
            return _buildBranchCard(viewModel.branches[index], viewModel);
          },
        ),
      ),
    );
  }

  Widget _buildBranchCard(BranchDto branch, BranchesModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Клиника: ${branch.clinicName}",
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                    onPressed: () async {
                      final mainOwnerId = Provider.of<OwnerMainModel>(context, listen: false).ownerId;

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider<EditBranchModel>(
                            create: (_) => EditBranchModel(branch: branch)..setOwnerId(mainOwnerId!),
                            child: EditBranchScreen(branch: branch),
                          ),
                        ),
                      );

                      // Если вернулись с результатом true, обновляем список филиалов
                      if (result == true) {
                        viewModel.loadBranches();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _showDeleteDialog(branch, viewModel),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          _buildInfoRow(Icons.location_on, "Адрес:", branch.address),
          _buildInfoRow(Icons.person, "Менеджер:", branch.managerName ?? "Не указан"),
          _buildInfoRow(Icons.calendar_today, "Праздники:", branch.description),
          _buildInfoRow(Icons.weekend, "Выходные:", branch.offDays),
          _buildInfoRow(Icons.access_time, "Время работы:", branch.workingHours),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.blue),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 5),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BranchDto branch, BranchesModel viewModel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удаление"),
        content: Text("Вы уверены, что хотите удалить филиал по адресу: ${branch.address}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Отмена"),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteBranch(branch.id);
              Navigator.pop(ctx);
            },
            child: const Text("Удалить", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}