import 'package:medhealth/common/BaseScreenModel.dart' show BaseScreenModel;
import 'package:medhealth/doctor/doctor_dashboard/dto/PatientAppointmentUi.dart';
import 'package:medhealth/doctor/doctor_dashboard/rep/DoctorDashboardRep.dart';
import 'package:medhealth/doctor/doctor_dashboard/ui/view/BookTimeDialogDoctor.dart';
import 'package:medhealth/doctor/doctor_dashboard/ui/view/PatientAppointmentStatus.dart';

class DoctorDashboardScreenModel extends BaseScreenModel {
  DoctorDashboardScreenModel();

  final String idDoctor = "1";
  List<PatientAppointmentUi> appointments = [];

  final _rep = DoctorDashboardRep();

  final Map<String, PatientAppointmentStatus> status = {};

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Future<void> onInitialization() async {
    final currentDate = DateTime.now();
    final date = getDateFromDateTime(currentDate);

    status.addAll(await setDoctorAppointments(idDoctor, date));
  }

  Future<Map<String, PatientAppointmentStatus>> setDoctorAppointments(
    String doctorId,
    String date,
  ) async {
    return _rep.getDoctorAppointments(doctorId: doctorId, date: date).then((
      onValue,
    ) {
      Map<String, PatientAppointmentStatus> result = {};

      appointments.clear();
      appointments.addAll(onValue);

      for (var element in onValue) {
        result[element.time] = element.status;
      }

      return result;
    });
  }

  Future<void> setDoctorAppointmentsUi(DateTime currentDate) async {
    isLoading = true;

    status.clear();
    status.addAll(
      await setDoctorAppointments(idDoctor, getDateFromDateTime(currentDate)),
    );

    isLoading = false;
    notifyListeners();
  }

  AppointmentData getAppointmentByTime(String time) {
    for (var appointment in appointments) {
      if (appointment.time == time) {
        return AppointmentData(
          symptomsDescription: appointment.symptomsDescription,
          selfTreatmentMethodsTaken: appointment.selfTreatmentMethodsTaken,
        );
      }
    }

    isError = true;

    return AppointmentData(
      symptomsDescription: "",
      selfTreatmentMethodsTaken: "",
    );
  }

  bool isNotFree(String time) {
    return status[time] != null;
  }


}
