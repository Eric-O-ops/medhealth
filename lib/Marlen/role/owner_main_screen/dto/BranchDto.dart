class BranchDto {
  final int id;
  final String address;
  final String description;
  final String clinicName;
  final String? managerName;
  final String workingHours;
  final String offDays;

  BranchDto({
    required this.id,
    required this.address,
    required this.description,
    required this.clinicName,
    this.managerName,
    this.workingHours = "09:00 - 18:00",
    this.offDays = "Сб, Вс",
  });

  factory BranchDto.fromJson(Map<String, dynamic> json) {
    String cName = "Без названия";
    if (json['clinic_owner'] != null) {
      cName = json['clinic_owner']['name_clinic'] ?? "Без названия";
    }

    String? mName;
    if (json['managers'] != null && (json['managers'] as List).isNotEmpty) {
      var firstManagerUser = json['managers'][0]['user'];
      if (firstManagerUser != null) {
        mName = "${firstManagerUser['first_name']} ${firstManagerUser['last_name']}";
      }
    }

    return BranchDto(
      id: json['id'] ?? 0,
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      clinicName: cName,
      managerName: mName,
      workingHours: json['working_hours'] ?? "09:00 - 18:00",
      offDays: json['off_days'] ?? "Сб, Вс",
    );
  }
}