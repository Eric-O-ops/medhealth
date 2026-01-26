class PatientDto {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String dateOfBirth;
  final String gender;
  final String? photoUrl;

  PatientDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    this.photoUrl,
  });

  factory PatientDto.fromJson(Map<String, dynamic> json) {
    String? rawPhoto = json['photo'];
    String? fullPhotoUrl;
    if (rawPhoto != null && rawPhoto.isNotEmpty) {
      fullPhotoUrl = rawPhoto.startsWith('http') ? rawPhoto : "http://127.0.0.1:8000$rawPhoto";
    }

    return PatientDto(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? 'male',
      photoUrl: fullPhotoUrl,
    );
  }
}