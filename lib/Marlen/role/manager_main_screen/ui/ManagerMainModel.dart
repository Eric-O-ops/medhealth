import '../../../../common/BaseScreenModel.dart';
import '../rep/ManagerRep.dart';

class ManagerMainModel extends BaseScreenModel {
  final ManagerRep _rep = ManagerRep();
  int selectedIndex = 0;
  int? branchId;
  @override
  Future<void> onInitialization() async {
    print("ManagerMainModel инициализирован.");
  }
  String clinicName = "Загрузка...";
  String branchAddress = "Загрузка...";

  void setTabIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setupManager(int bId) {
    branchId = bId;
    _rep.setBranchId(bId);
    loadBranchInfo();
  }

  Future<void> loadBranchInfo() async {
    try {
      final res = await _rep.fetchBranchInfo();
      if (res.code == 200) {
        // Убедитесь, что ключи совпадают с вашим JSON (clinic_owner -> name_clinic)
        clinicName = res.body['clinic_owner']?['name_clinic'] ?? "Клиника";
        branchAddress = res.body['address'] ?? "Адрес не указан";
        notifyListeners();
      }
    } catch (e) {
      print("Ошибка получения инфо о филиале: $e");
    }
  }
}