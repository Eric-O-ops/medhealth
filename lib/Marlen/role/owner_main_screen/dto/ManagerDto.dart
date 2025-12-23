class ManagerDto {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final int? branchId;

  ManagerDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.branchId,
  });

  factory ManagerDto.fromJson(Map<String, dynamic> json) {
    // Извлекаем вложенный объект 'user'
    final userData = json['user'] as Map<String, dynamic>?;

    return ManagerDto(
      id: json['id'] ?? 0,
      // Берем данные из вложенного userData
      email: userData?['email'] ?? '',
      firstName: userData?['first_name'] ?? '',
      lastName: userData?['last_name'] ?? '',
      role: userData?['role'] ?? '',
      // branch может приходить как объект или null
      branchId: json['branch'] is Map ? json['branch']['id'] : null,
    );
  }
}