class BranchDto {
  final int id;
  final String address;
  final String managerName; // Добавляем это
  final String holiday;     // И это
  final int? managerId;     // Для редактирования

  BranchDto({
    required this.id,
    required this.address,
    this.managerName = "Не назначен",
    this.holiday = "Нет",
    this.managerId,
  });

  factory BranchDto.fromJson(Map<String, dynamic> json) {
    return BranchDto(
      id: json['id'] as int? ?? 0,
      address: json['address'] as String? ?? '',
      // Если в JSON прилетает менеджер, вытаскиваем имя
      managerName: json['manager'] != null
          ? "${json['manager']['first_name']} ${json['manager']['last_name']}"
          : "Не назначен",
      holiday: json['description'] as String? ?? "Нет",
      managerId: json['manager'] != null ? json['manager']['id'] as int? : null,
    );
  }
}