class LoginUserDto {
  final String email;
  final String passwordUser;
  final String role;

  LoginUserDto({
    required this.email,
    required this.passwordUser,
    required this.role,
  });

  factory LoginUserDto.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return LoginUserDto(
      email: user['email'] ?? '',
      passwordUser: user['password_user'] ?? '',
      role: user['role'] ?? '',
    );
  }
}
