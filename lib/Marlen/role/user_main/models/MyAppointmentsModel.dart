import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:medhealth/common/RAM.dart';
import '../rep/PatientRep.dart';

class MyAppointmentsModel extends BaseScreenModel {
  final PatientRep _rep = PatientRep();
  List<dynamic> appointments = [];

  @override
  Future<void> onInitialization() async {
    await loadAppointments();
  }

  Future<void> loadAppointments() async {
    final userId = Ram().userId;

    // ПРОВЕРКА: Если гость (id пустой), не делаем запрос к серверу
    if (userId == null || userId.isEmpty) {
      appointments = [];
      isLoading = false;
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final resp = await _rep.fetchPatientAppointments(userId);
      if (resp.code == 200) {
        appointments = (resp.body as List).reversed.toList();
      }
    } catch (e) {
      print("Ошибка загрузки записей: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelBooking(dynamic appointment) async {
    final userId = Ram().userId;
    if (userId == null || userId.isEmpty) return;

    final success = await _rep.cancelAppointment(
      patientId: userId,
      doctorId: appointment['doctor_id'].toString(),
      date: appointment['date'],
      time: appointment['time'],
    );

    if (success.code == 200) {
      await loadAppointments();
    }
  }
}