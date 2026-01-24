import 'package:medhealth/common/BaseScreenModel.dart';
import '../rep/PatientRep.dart'; // Путь к твоему репозиторию

class UserMainModel extends BaseScreenModel {
  final PatientRep _patientRep = PatientRep();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<dynamic> clinics = [];

  void setTabIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  @override
  Future<void> onInitialization() async {
    await loadClinics();
  }

  Future<void> loadClinics() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _patientRep.fetchAllClinics();
      if (response.code == 200 && response.body is List) {
        clinics = response.body;
      }
    } catch (e) {
      print("Ошибка загрузки клиник: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}