// post current day or other for init
// convert json to Map<String, StatusRegistration>

// make convert  Map<String, StatusRegistration> to json if was selected time of day
// then post new data to backend

// add new task for http code
// setting sign in and up

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medhealth/common/RAM.dart';

import '../../../http/HttpRequest.dart';
import '../dto/PatientAppointmentDoctorDto.dart';
class PatientDashboardApi {

  Future<Response> fetchDoctorAppointments( {
    required String doctorId,
    required String date,
  }) {
    return dioHttpRequest.post('api/appointments/slots/current-day', data: {
      'date': date,
      'doctorId': doctorId,
    });
  }

  Future<Response> postPatientAppointment(
    PatientAppointmentDoctorDto patientAppointment,
  ) {

    final parts = patientAppointment.time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return dioHttpRequest.post('api/appointments/register', data: {
      'doctorId': patientAppointment.doctorId,
      'patientId': int.parse(Ram().userId),
      'date': patientAppointment.date,
      'time': {
        "hour": hour,
        "minute": minute
      },
      'symptomsDescribedByPatient': patientAppointment.symptomsDescription,
      'selfTreatmentMethodsTaken': patientAppointment.selfTreatmentMethodsTaken,
    });
  }

  Future<Response> removePatientAppointment(
      PatientAppointmentDoctorDto patientAppointment,
      int patientId,
      ) {

    final parts = patientAppointment.time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return dioHttpRequest.post(
      'api/appointments/cancel/',
      data: {
        "patientId": patientId,
        "doctorId": patientAppointment.doctorId,
        "date": patientAppointment.date,
        'time': {
          "hour": hour,
          "minute": minute
        },
      },
    );
  }

  Future<Response> fetchDoctors() {
    return dioHttpRequest.get('api/doctors/');
  }
}
