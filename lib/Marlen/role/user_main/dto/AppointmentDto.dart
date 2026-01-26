class AppointmentDto {
  final int id;
  final String doctorName;
  final String specialization;
  final String date;
  final String time;

  AppointmentDto({
    required this.id,
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
  });

  factory AppointmentDto.fromJson(Map<String, dynamic> json) {
    var doc = json['doctor_details'] ?? {};
    var user = doc['user'] ?? {};

    return AppointmentDto(
      id: json['id'] ?? 0,
      doctorName: "${user['first_name'] ?? ''} ${user['last_name'] ?? ''}",
      specialization: doc['specialization'] ?? 'Врач',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}