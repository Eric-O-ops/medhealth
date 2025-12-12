import 'dart:io';

import 'package:dio/dio.dart';

import '../../../http/HttpRequest.dart';
class DoctorDashboardApi {

  Future<Response> fetchDoctorAppointments( {
    required String doctorId,
    required String date,
  }) {
    return dioHttpRequest.post('api/doctors/appointments/daily/', data: {
      'date': date,
      'doctorId': doctorId,
    });
  }

}
