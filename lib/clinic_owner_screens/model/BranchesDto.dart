class BranchDto {

  final int id;
  final String nameClinic;
  final String address;


  BranchDto({
    required this.id,
    required this.address,
    required this.nameClinic
  });

  factory BranchDto.fromJson(Map<String, dynamic> json) {
    return BranchDto(
      id: json['id'] as int,
      address: json['address'] as String,
      nameClinic: json['clinic_owner']['name_clinic'] as String,
    );
  }

}
