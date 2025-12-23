import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../../../clinic_owner_screens/model/BranchesDto.dart';
import '../dto/BranchDto.dart';
import '../model/BranchesModel.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});
  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends BaseScreen<BranchesScreen, BranchesModel> {

  @override
  Widget buildBody(BuildContext context, BranchesModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Мои филиалы", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.branches.isEmpty
          ? const Center(child: Text("Филиалы не добавлены"))
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: viewModel.branches.length,
        itemBuilder: (context, index) {
          return _buildBranchCard(viewModel.branches[index], viewModel);
        },
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
              const Text("Филиал клиники",
                  style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      // TODO: Переход на экран редактирования
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => EditBranchScreen(branch: branch)));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(branch, viewModel),
                  ),
                ],
              )
            ],
          ),
          const Divider(),
          _buildInfoRow(Icons.location_on, "Адрес:", branch.address),
          _buildInfoRow(Icons.person, "Менеджер:", branch.managerName),
          _buildInfoRow(Icons.calendar_today, "Праздник:", branch.holiday),
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
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
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
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена")),
          TextButton(
              onPressed: () {
                viewModel.deleteBranch(branch.id);
                Navigator.pop(ctx);
              },
              child: const Text("Удалить", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}