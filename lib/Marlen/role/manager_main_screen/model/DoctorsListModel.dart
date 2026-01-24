import '../../../../common/BaseScreenModel.dart';
import '../dto/DoctorDto.dart';
import '../rep/ManagerRep.dart';

class DoctorsListModel extends BaseScreenModel {
  final ManagerRep _rep = ManagerRep();
  List<DoctorDto> _doctors = [];
  String branchWorkingHours = "Не указано";
  int? _branchId;

  List<DoctorDto> get doctors => _doctors;
  int? get branchId => _branchId;

  void setup(int id) {
    _branchId = id;
    _rep.setBranchId(id);
    refreshData();
  }

  // Future<void> refreshData() async {
  //   isLoading = true;
  //   notifyListeners();
  //   await loadBranchInfo();
  //   await loadDoctors();
  //   isLoading = false;
  //   notifyListeners();
  // }
  Future<void> refreshData() async {
    // Не ставим isLoading = true, чтобы не мигал белый экран,
    // RefreshIndicator сам покажет крутилку сверху
    try {
      await loadBranchInfo(); // Обновляем время работы филиала
      await loadDoctors();    // Обновляем список врачей
    } catch (e) {
      print("Ошибка при обновлении: $e");
    } finally {
      notifyListeners(); // Уведомляем UI об изменениях
    }
  }
  Future<void> loadBranchInfo() async {
    final res = await _rep.getBranchConstraints();
    if (res.code == 200) {
      branchWorkingHours = res.body['working_hours'] ?? "Не указано";
    }
  }

  Future<void> loadDoctors() async {
    final res = await _rep.fetchMyDoctors();
    if (res.code == 200 && res.body is List) {
      _doctors = (res.body as List).map((e) => DoctorDto.fromJson(e)).toList();
    }
  }

  Future<void> deleteDoctor(int id) async {
    print("Попытка удаления врача с ID: $id"); // Для отладки
    final res = await _rep.deleteDoctor(id);

    if (res.code == 200 || res.code == 204) {
      print("Удаление успешно");
      _doctors.removeWhere((d) => d.id == id);
      notifyListeners(); // Генерирует обновление экрана
    } else {
      print("Ошибка API при удалении: ${res.code} - ${res.body}");
    }
  }

  @override
  Future<void> onInitialization() {
    // TODO: implement onInitialization
    throw UnimplementedError();
  }
}