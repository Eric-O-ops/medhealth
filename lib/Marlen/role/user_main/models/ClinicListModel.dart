import 'package:medhealth/common/BaseScreenModel.dart';

import '../dto/ClinicDTO.dart';
import '../rep/PatientRep.dart';

class ClinicListModel extends BaseScreenModel {
  final PatientRep _rep = PatientRep();

  // Мы строго указываем тип списка
  List<ClinicDto> _clinics = [];
  List<ClinicDto> get clinics => _clinics;

  @override
  Future<void> onInitialization() async {}

  Future<void> loadClinics() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _rep.fetchAllClinics();

      if (response.code == 200 && response.body is List) {
        final List<dynamic> rawList = response.body;
        _clinics = rawList
            .map((e) => ClinicDto.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print("Ошибка загрузки клиник: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}