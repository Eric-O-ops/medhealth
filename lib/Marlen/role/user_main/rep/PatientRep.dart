import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:medhealth/common/BaseApi.dart';

class PatientRep extends BaseApi {

  Future<Response> fetchAllClinics() async {
    return await fetch("api/patient/clinics/");
  }

  Future<Response> fetchDoctorsByBranch(int branchId) async {
    return await fetch("api/doctors/?branch_id=$branchId");
  }

  Future<Response> fetchPatientAppointments(String patientId) async {
    return await fetch("api/appointments/patient/?patient_id=$patientId");
  }

  Future<Response> fetchPatientHistory(String patientId) async {
    return await fetch("api/appointments/?patient_id=$patientId&status=completed");
  }

  Future<Response> updatePatientProfile(String userId, Map<String, String> data, File? image) async {
    var request = http.MultipartRequest('PATCH', Uri.parse("${baseUrl}api/users/$userId/"));

    request.fields.addAll(data);

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', image.path));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    dynamic responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (_) {
      responseBody = response.body;
    }

    return Response(
      code: response.statusCode,
      body: responseBody,
    );
  }
  Future<Response> cancelAppointment({
    required String patientId,
    required String doctorId,
    required String date,
    required String time,
  }) async {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final url = Uri.parse("${baseUrl}api/appointments/cancel/");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'patientId': int.parse(patientId),
        'doctorId': int.parse(doctorId),
        'date': date,
        'time': {'hour': hour, 'minute': minute},
      }),
    );

    dynamic responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (_) {
      responseBody = response.body;
    }

    return Response(
      code: response.statusCode,
      body: responseBody,
    );
  }
}