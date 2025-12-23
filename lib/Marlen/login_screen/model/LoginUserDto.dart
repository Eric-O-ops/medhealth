class LoginUserDto {
  final int id; // ⭐️ Добавлено
  final String email;
  final String passwordUser;
  final String role;

  LoginUserDto({
    required this.id,
    required this.email,
    required this.passwordUser,
    required this.role,
  });

  factory LoginUserDto.fromJson(Map<String, dynamic> json) {
    return LoginUserDto(
      id: json['id'] ?? 0, // ⭐️ Добавлено
      email: json['email'] ?? '',
      passwordUser: json['password_user'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
