import 'package:flutter/material.dart';
import 'package:medhealth/doctor/doctor_dashboard/dto/PatientAppointmentUi.dart';
import 'package:medhealth/doctor/doctor_dashboard/ui/view/PatientAppointmentStatus.dart';

import '../api/DoctorDashboardApi.dart';
import 'package:intl/intl.dart' show DateFormat;

class DoctorDashboardRep {
  final _api = DoctorDashboardApi();


  Future<bool> setAppointmentAsCompleted({
    required int doctorId,
    required String patientId,
    required DateTime date,
    required String time,
  }) async {
    final response = await _api.setAppointmentAsCompleted(
      doctorId: doctorId,
      patientId: patientId,
      date: getDate(dataTime: date),
      time: time,
    );

    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setAppointmentAsNoShow({
    required int doctorId,
    required String patientId,
    required DateTime date,
    required String time,
  }) async {
    final response = await _api.setAppointmentAsNoShow(
      doctorId: doctorId,
      patientId: patientId,
      date: getDate(dataTime: date),
      time: time,
    );

    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PatientAppointmentUi>> getDoctorAppointments({
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

    List<PatientAppointmentUi> result = [];

    for (var element in jsonList) {
      PatientAppointmentUi patientAppointment = PatientAppointmentUi.empty();

      if (element['status'] == 'completed') {
        patientAppointment.status = PatientAppointmentStatus.completed;
      }

      if (element['status'] == 'scheduled') {
        patientAppointment.status = PatientAppointmentStatus.scheduled;
      }

      if (element['status'] == 'no_show') {
        patientAppointment.status = PatientAppointmentStatus.no_show;
      }

      patientAppointment.time = element['time'];
      patientAppointment.date = element['date'];
      patientAppointment.doctorId = element['doctor_id'].toString();
      patientAppointment.patientId = element['patient_id'].toString();
      patientAppointment.symptomsDescription = element['symptomsDescribedByPatient'];
      patientAppointment.selfTreatmentMethodsTaken = element['selfTreatmentMethodsTaken'];

      result.add(patientAppointment);
    }

    return result;
  }
}

String getTime(String iso) {
  DateTime dt = DateTime.parse(iso);

  String time =
      "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";

  return time;
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
