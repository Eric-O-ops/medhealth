class DoctorDto {
  final int id;
  final int userId;
  final int branchId;
  final String firstName;
  final String lastName;
  final String email;
  final String specialization;
  final double price;
  final String education;
  final int experience;
  final String description;
  final String workingHours;
  final String offDays;
  final String gender;
  final int age;
  final String? photoUrl;
  final String branchDescription; // Праздники из филиала

  DoctorDto({
    required this.id,
    required this.userId,
    required this.branchId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.specialization,
    required this.price,
    required this.education,
    required this.experience,
    required this.description,
    this.workingHours = "",
    this.offDays = "",
    required this.gender,
    required this.age,
    this.photoUrl,
    this.branchDescription = "",
  });

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    String? rawPhoto = json['photo'] ?? json['photo_url'];

    // Формируем полный URL для картинки
    String? fullPhotoUrl;
    if (rawPhoto != null && rawPhoto.isNotEmpty) {
      if (rawPhoto.startsWith('http')) {
        fullPhotoUrl = rawPhoto;
      } else {
        // Замените на IP вашего сервера, если тестируете не на эмуляторе
        fullPhotoUrl = "http://127.0.0.1:8000$rawPhoto";
      }
    }

    return DoctorDto(
      id: json['id'] ?? 0,
      userId: json['user']?['id'] ?? 0,
      // Исправляем получение branchId, так как в JSON может прийти объект или ID
      branchId: json['branch'] is int
          ? json['branch']
          : (json['branch_id'] ?? (json['branch']?['id'] ?? 0)),
      firstName: json['user']?['first_name'] ?? '',
      lastName: json['user']?['last_name'] ?? '',
      email: json['user']?['email'] ?? '',
      specialization: json['specialization'] ?? 'Врач',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      education: json['education'] ?? '',
      experience: json['experience_years'] ?? 0,
      description: json['description'] ?? '',
      workingHours: json['working_hours'] ?? "09:00 - 21:00",
      offDays: json['off_days'] ?? '',
      gender: json['gender'] ?? 'male',
      age: json['age'] ?? 25,
      photoUrl: fullPhotoUrl,
      // Подтягиваем праздники из нового поля сериализатора
      branchDescription: json['branch_description'] ?? "",
    );
  }
}