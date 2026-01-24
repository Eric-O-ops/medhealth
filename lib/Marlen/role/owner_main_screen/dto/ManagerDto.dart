class ManagerDto {
  final int id;
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final int? branchId;

  ManagerDto({
    required this.id,
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.branchId,
  });

  factory ManagerDto.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] as Map<String, dynamic>?;

    return ManagerDto(
      id: json['id'] ?? 0,
      userId: userData?['id'] ?? 0,
      email: userData?['email'] ?? '',
      firstName: userData?['first_name'] ?? '',
      lastName: userData?['last_name'] ?? '',
      role: userData?['role'] ?? '',
      branchId: json['branch'] is Map ? json['branch']['id'] : (json['branch'] is int ? json['branch'] : null),
    );
  }
}