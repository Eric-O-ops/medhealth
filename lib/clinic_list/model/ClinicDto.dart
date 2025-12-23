class ClinicDto {
  final int idOwner;
  final String name;

  ClinicDto({required this.idOwner, required this.name});

  factory ClinicDto.fromJson(Map<String, dynamic> json) {
    return ClinicDto(
      idOwner: json['id'] as int,
      name: json['name_clinic'] as String,
    );
  }



}