// lib/clinic_list/models/ClinicDto.dart
class ClinicDto {
  final int id;
  final String name;
  final int branchesCount; // Проверь это имя!

  ClinicDto({
    required this.id,
    required this.name,
    required this.branchesCount,
  });

  factory ClinicDto.fromJson(Map<String, dynamic> json) {
    return ClinicDto(
      id: json['id'] ?? 0,
      name: json['name_clinic'] ?? "Без названия",
      // В JSON от сервера приходит 'branches_count',
      // а в объекте мы сохраняем как branchesCount
      branchesCount: json['branches_count'] ?? 0,
    );
  }
}