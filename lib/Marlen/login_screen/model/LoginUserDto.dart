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
    return LoginUserDto(
      email: json['email'] ?? '',
      passwordUser: json['password_user'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
