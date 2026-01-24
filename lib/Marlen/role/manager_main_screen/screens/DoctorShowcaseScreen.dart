import 'package:flutter/material.dart';
import '../../../../styles/app_colors.dart';
import '../dto/DoctorDto.dart';

class DoctorShowcaseScreen extends StatelessWidget {
  final List<DoctorDto> doctors;
  final bool isLoading;
  final String clinicName;
  final String branchAddress;
  final String branchWorkingHours; // 1. Добавили поле
  final Function(DoctorDto) onEdit;
  final Function(int) onDelete;
  final Future<void> Function() onRefresh; // 2. Добавили функцию для свайпа

  const DoctorShowcaseScreen({
    super.key,
    required this.doctors,
    required this.isLoading,
    required this.clinicName,
    required this.branchAddress,
    required this.branchWorkingHours, // 3. В конструктор
    required this.onEdit,
    required this.onDelete,
    required this.onRefresh, // 4. В конструктор
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Блок информации о клинике и филиале
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.blue.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.business, size: 20, color: AppColors.blue),
                    const SizedBox(width: 8),
                    Text("Клиника: $clinicName",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text("Филиал: $branchAddress", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          // Счетчик врачей
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Всего врачей в филиале: ${doctors.length}",
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue),
            ),
          ),

          if (doctors.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text("Список врачей пуст"),
            ))
          else
            ...doctors.map((doctor) => _buildFullDoctorCard(context, doctor)).toList(),
        ],
      ),
    );
  }

  Widget _buildFullDoctorCard(BuildContext context, DoctorDto doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.blue.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: doctor.photoUrl != null && doctor.photoUrl!.isNotEmpty
                      ? Image.network(
                    doctor.photoUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 40, color: AppColors.blue);
                    },
                  )
                      : const Icon(Icons.person, size: 40, color: AppColors.blue),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${doctor.firstName} ${doctor.lastName}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      doctor.specialization,
                      style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => onEdit(doctor),
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 22),
                  ),
                  IconButton(
                    onPressed: () => onDelete(doctor.id),
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 30, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoTile("Цена", "${doctor.price} сом"),
              _infoTile("Стаж", "${doctor.experience} лет"),
              _infoTile("Возраст", "${doctor.age} лет"),
              // Исправляем отображение пола
              _infoTile("Пол", doctor.gender == 'male' ? "Мужской" : "Женский"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _iconDetail(Icons.calendar_month, "Рабочие дни", doctor.offDays.isEmpty ? "Не указаны" : doctor.offDays),
              ),
              Expanded(
                child:_iconDetail(Icons.access_time, "Часы работы", branchWorkingHours),//здесь горит красным откуда ты взял branchWorkingHours?
              ),
            ],
          ),
          const SizedBox(height: 10),
          _iconDetail(Icons.celebration, "Праздники", doctor.branchDescription.isEmpty ? "По графику" : doctor.branchDescription),
          const SizedBox(height: 15),
          _textSection("Образование", doctor.education),
          const SizedBox(height: 10),
          _textSection("О себе", doctor.description),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue, fontSize: 14)),
      ],
    );
  }

  Widget _iconDetail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 2),
        Text(
          content.isEmpty ? "Информация отсутствует" : content,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }
}