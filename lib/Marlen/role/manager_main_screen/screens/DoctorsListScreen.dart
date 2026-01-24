import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../dto/DoctorDto.dart';
import '../model/AddDoctorModel.dart';
import '../model/DoctorsListModel.dart';
import 'EditDoctorScreen.dart';

class DoctorsListScreen extends StatelessWidget {
  final List<DoctorDto> doctors;
  final Function(int) onDelete;
  final Function(DoctorDto) onEdit;

  const DoctorsListScreen({
    super.key,
    required this.doctors,
    required this.onDelete,
    required this.onEdit,
  });

  Widget _buildDoctorRow(BuildContext context, DoctorDto doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.blue.withOpacity(0.1),
            child: Icon(
              doctor.gender == 'male' ? Icons.person : Icons.person_3,
              color: AppColors.blue,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${doctor.firstName} ${doctor.lastName}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  doctor.specialization,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.blue),
            onPressed: () => onEdit(doctor), // Используем переданный колбэк
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _confirmDelete(context, doctor),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, DoctorDto doctor) {
    // ВАЖНО: Захватываем модель ДО открытия диалога
    final model = Provider.of<DoctorsListModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удаление"),
        content: Text("Вы уверены, что хотите удалить врача ${doctor.lastName}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена")),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx); // Закрываем диалог
              // Вызываем удаление через захваченную модель
              await model.deleteDoctor(doctor.id);
            },
            child: const Text("Удалить", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Управление врачами", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: doctors.isEmpty
          ? const Center(child: Text("Список врачей пуст"))
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: doctors.length,
        itemBuilder: (context, index) => _buildDoctorRow(context, doctors[index]),
      ),
    );
  }
}