import 'dart:io';

import 'package:dio/dio.dart';

import '../../../http/HttpRequest.dart';

class DoctorDashboardApi {
  Future<Response> fetchDoctorAppointments({
    required String doctorId,
    required String date,
  }) {
    return dioHttpRequest.post(
      'api/doctors/appointments/daily/',
      data: {'date': date, 'doctorId': doctorId},
    );
  }

  Future<Response> setAppointmentAsCompleted({
    required int doctorId,
    required String patientId,
    required String date,
    required String time,
  }) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return dioHttpRequest.post(
      'api/appointments/patient-attended/',
      data: {
        'doctorId': doctorId,
        'patientId': patientId,
        'date': date,
        'time': {'hour': hour, 'minute': minute},
      },
    );
  }

  Future<Response> setAppointmentAsNoShow({
    required int doctorId,
    required String patientId,
    required String date,
    required String time,
  }) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return dioHttpRequest.post(
      'api/appointments/no-show-by-data/',
      data: {
        'doctorId': doctorId,
        'patientId': patientId,
        'date': date,
        'time': {'hour': hour, 'minute': minute},
      },
    );
  }
}
