// Внутри OwnerRegistrationDto.dart (Изменяем структуру)

class OwnerRegistrationDto {
  final String email;
  final String password;
  final String clinicName;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dateOfBirth;

  OwnerRegistrationDto({
    required this.email,
    required this.password,
    required this.clinicName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.dateOfBirth = "2000-01-01",
  });

  Map<String, dynamic> toJson() {
    return {
      'name_clinic': clinicName,

      // 🔥 ВЛОЖЕННЫЙ ОБЪЕКТ ПОЛЬЗОВАТЕЛЯ, как ожидает ClinicOwnerSerializer
      'user': {
        // Обязательные поля CustomUser
        'email': email,
        'password': password, // Для create_user
        'password_user': password, // Для кастомного поля
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth, // Важно!
        'address': 'г.Бишкек', // Предположим, что адрес опционален или пуст
        'role': 'owner', // Жестко задаем роль!
      },
    };
  }
}