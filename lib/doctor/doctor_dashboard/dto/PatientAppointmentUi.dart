import 'dart:core';

import 'package:medhealth/doctor/doctor_dashboard/ui/view/PatientAppointmentStatus.dart' show PatientAppointmentStatus;

class PatientAppointmentUi {

  late String date;
  late String time;
  late String doctorId;
  late String patientId;
  late PatientAppointmentStatus status;
  late String symptomsDescription;
  late String selfTreatmentMethodsTaken;

  PatientAppointmentUi({
    required String date,
    required String time,
    required String doctorId,
    required String patientId,
    required PatientAppointmentStatus status,
    required String symptomsDescription,
    required String selfTreatmentMethodsTaken
  });

  PatientAppointmentUi.empty() {
    date = "";
    time = "";
    doctorId = "";
    patientId = "";
    status = PatientAppointmentStatus.free;
    symptomsDescription = "";
    selfTreatmentMethodsTaken = "";
  }

}