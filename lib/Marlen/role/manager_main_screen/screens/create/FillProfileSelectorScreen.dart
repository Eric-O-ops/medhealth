// Файл: screens/FillProfileSelectorScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/DoctorDto.dart';
import '../../model/FillDoctorProfileModel.dart';
import 'FillDoctorProfileFormScreen.dart';
import 'package:medhealth/styles/app_colors.dart';

class FillProfileSelectorScreen extends StatelessWidget {
  final List<DoctorDto> doctors;
  const FillProfileSelectorScreen({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        title: const Text("Выберите врача"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: doctors.isEmpty
          ? const Center(
        child: Text(
          "Нет врачей для заполнения профиля",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doc = doctors[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => FillDoctorProfileModel()..setup(doc),
                    child: const FillDoctorProfileFormScreen(),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                    child: const Icon(Icons.person, color: AppColors.blue, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${doc.firstName} ${doc.lastName}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          doc.specialization,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}