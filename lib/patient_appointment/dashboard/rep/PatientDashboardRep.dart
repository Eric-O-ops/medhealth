import '../api/PatientDashboardApi.dart';
import '../dto/DoctorInfoDto.dart';
import '../dto/PatientAppointmentDoctorDto.dart';
import '../ui/view/StatusRegistration.dart';
import 'package:intl/intl.dart' show DateFormat;

class PatientDashboardRep {
  final _api = PatientDashboardApi();

  Future<Map<String, StatusRegistration>> getDoctorAppointments({
    required String doctorId,
    required String date,
  }) async {
    final response = await _api.fetchDoctorAppointments(
      doctorId: doctorId,
      date: date,
    );

    final List<Map<String, dynamic>> jsonList = (response.data as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    final Map<String, StatusRegistration> result = {};

    for (var element in jsonList) {
      StatusRegistration status;
      if (element['busyStatus'] == 'busy' && element['patientId'] != 12) {
        status = StatusRegistration.busy;
      } else if (element['busyStatus'] == 'busy' &&
          element['patientId'] == 12) {
        status = StatusRegistration.mine;
      } else {
        status = StatusRegistration.free;
      }

      final String timeKey = getTime(element['dateTime']);

      result[timeKey] = status;
    }

    return result;
  }

  Future<bool> postPatientAppointment(
      PatientAppointmentDoctorDto patientAppointment,) async {
    final patientAppointmentWithFormat = PatientAppointmentDoctorDto(
      doctorId: patientAppointment.doctorId,
      date: patientAppointment.date,
      time: patientAppointment.time,
      symptomsDescription: patientAppointment.symptomsDescription,
      selfTreatmentMethodsTaken: patientAppointment.selfTreatmentMethodsTaken,
    );

    try {
      final response = await _api.postPatientAppointment(
        patientAppointmentWithFormat,
      );

      if (response.statusCode != null &&
          (response.statusCode! >= 200 && response.statusCode! < 300)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Ошибка при записи на прием: $e');
      return false;
    }
  }

  Future<List<DoctorInfoDto>> fetchDoctors() async {
    final response = await _api.fetchDoctors();

    final List<dynamic> jsonList = response.data;

    return jsonList
        .map((e) => DoctorInfoDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<bool> removePatientAppointment(
      PatientAppointmentDoctorDto patientAppointment,
      int patientId,) async {
    final res = await _api.removePatientAppointment(
        patientAppointment, patientId);
    return res.statusCode == 200;
  }

  String getTime(String iso) {
    DateTime dt = DateTime.parse(iso);

    String time =
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(
        2, '0')}";

    return time;
  }
}

  String getDate({required DateTime dataTime}) {
    DateTime result = DateTime(dataTime.year, dataTime.month, dataTime.day);

    final formatted = DateFormat('yyyy-MM-dd').format(result);

    return formatted;
  }

  String getDateFromDateTime(DateTime dateTime) {
    final year = dateTime.year.toString();
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
