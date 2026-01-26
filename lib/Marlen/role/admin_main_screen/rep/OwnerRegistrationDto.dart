
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

      'user': {
        'email': email,
        'password': password,
        'password_user': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth,
        'address': 'г.Бишкек',
        'role': 'owner',
      },
    };
  }
}