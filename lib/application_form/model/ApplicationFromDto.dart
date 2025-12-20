class ApplicationFromDto {
  final int id;
  final String firstName;
  final String lastName;
  final String nameClinic;
  final String email;
  final String phoneNumber;
  final String description;

  ApplicationFromDto({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.nameClinic,
    required this.email,
    required this.phoneNumber,
    required this.description,
  });

  factory ApplicationFromDto.fromJson(Map<String, dynamic> json) {
    return ApplicationFromDto(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      nameClinic: json['name_clinic'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'name_clinic': nameClinic,
      'email': email,
      'phone_number': phoneNumber,
      'description': description,
    };
  }

}