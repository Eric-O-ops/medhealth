class DoctorDto {
  final int id;
  final int userId;
  final String firstName;
  final String lastName;
  final String phone;
  final String education;
  final String description; // О себе
  final int experience; // Стаж
  final String specialization; // Специальность (пока текстом или ID)
  // Для графика работы (пока сохраняем как строку, например "Пн, Ср, Пт")
  final String schedule;
  final int? branchId;

  DoctorDto({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.education,
    required this.description,
    required this.experience,
    required this.specialization,
    this.schedule = "Пн-Пт",
    this.branchId,
  });

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    // В Django сериализаторе данные пользователя часто лежат внутри поля 'user'
    final user = json['user'] ?? {};

    return DoctorDto(
        id: json['id'] ?? 0,
        userId: user['id'] ?? 0,
        firstName: user['first_name'] ?? '',
        lastName: user['last_name'] ?? '',
        phone: user['phone_number'] ?? '',
        education: json['education'] ?? '',
        description: json['description'] ?? '',
        experience: json['experience_years'] ?? 0,
        // Если на бэке поле specialization это choice, оно придет строкой
        specialization: json['specialization'] ?? 'Терапевт',
        branchId: json['branch'],
        schedule: json['schedule'] ?? "Пн-Пт 09:00-18:00" // Предполагаем поле
    );
  }
}