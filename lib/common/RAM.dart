class Ram {
  Ram._internal();

  static final Ram _instance = Ram._internal();

  factory Ram() {
    return _instance;
  }

  String doctorId = "";
  String userId = "";

  String getDoctorId() => doctorId;
  String getUserId() => userId;
}