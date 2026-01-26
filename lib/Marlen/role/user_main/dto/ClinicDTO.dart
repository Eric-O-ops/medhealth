class ClinicDto {
  final int id;
  final String name;
  final int branchesCount;

  ClinicDto({
    required this.id,
    required this.name,
    required this.branchesCount,
  });

  factory ClinicDto.fromJson(Map<String, dynamic> json) {
    return ClinicDto(
      id: json['id'] ?? 0,
      name: json['name_clinic'] ?? "Без названия",
      branchesCount: json['branches_count'] ?? 0,
    );
  }
}