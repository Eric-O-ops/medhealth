class BranchDto {
  final int id;
  final String address;
  final String description; // Это поле из базы (Праздники)
  final String workingHours;
  final String offDays;
  final String managerName;
  final String clinicName;

  BranchDto({
    required this.id,
    required this.address,
    required this.description,
    required this.workingHours,
    required this.offDays,
    required this.clinicName,
    this.managerName = "Не назначен",
  });

  // Геттер для удобства, чтобы в коде экрана писать branch.holiday
  String get holiday => description.isEmpty ? "Нет" : description;

  factory BranchDto.fromJson(Map<String, dynamic> json) {
    String mName = "Не назначен";
    if (json['managers'] != null && (json['managers'] as List).isNotEmpty) {
      var firstManager = json['managers'][0]['user'];
      mName = "${firstManager['first_name']} ${firstManager['last_name']}";
    }

    return BranchDto(
      id: json['id'] ?? 0,
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      workingHours: json['working_hours'] ?? '10:00 - 17:00',
      offDays: json['off_days'] ?? 'Сб, Вс',
      clinicName: json['clinic_owner']?['name_clinic'] ?? "Без названия",
      managerName: mName,
    );
  }
}