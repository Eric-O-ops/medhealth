// Файл: lib/clinic_list/ui/ClinicsListScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../dto/ClinicDTO.dart';
import '../models/ClinicListModel.dart';
import 'BranchesListScreen.dart'; // Создадим этот файл ниже

class ClinicsListScreen extends StatelessWidget {
  const ClinicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wight,
      appBar: AppBar(
        title: const Text("Медицинские клиники", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<ClinicListModel>(
        builder: (context, model, child) {
          if (model.isLoading) return const Center(child: CircularProgressIndicator());
          if (model.clinics.isEmpty) return const Center(child: Text("Клиники не найдены"));

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: model.clinics.length,
            itemBuilder: (context, index) {
              final ClinicDto clinic = model.clinics[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BranchesListScreen(ownerId: clinic.id, clinicName: clinic.name),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(18),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.blue.withOpacity(0.1),
                        child: const Icon(Icons.business, color: AppColors.blue, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(clinic.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            const SizedBox(height: 4),
                            Text("Доступно филиалов: ${clinic.branchesCount}",
                                style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.blue),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}