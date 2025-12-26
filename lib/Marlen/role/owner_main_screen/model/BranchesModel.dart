import 'package:medhealth/common/BaseScreenModel.dart';
import '../dto/BranchDto.dart';
import '../rep/OwnerRep.dart';

class BranchesModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();
  List<BranchDto> _branches = [];

  List<BranchDto> get branches => _branches;
  void updateOwnerId(int id) {
    _rep.setOwnerId(id);
    loadBranches(); // Теперь загружаем уже с правильным ID
  }
  @override
  Future<void> onInitialization() async {
  }

  Future<void> loadBranches() async {
    print("!!! ВЫЗВАН МЕТОД loadBranches !!!"); // <--- ДОБАВЬ ЭТО
    isLoading = true;
    notifyListeners();
    try {
      final response = await _rep.fetchBranches();
      print("ОТВЕТ ПО ФИЛИАЛАМ: ${response.code} | ТЕЛО: ${response.body}"); // <--- И ЭТО

      if (response.code == 200 && response.body is List) {
        _branches = (response.body as List)
            .map((e) => BranchDto.fromJson(e))
            .toList();
        print("РАСПАРШЕНО ФИЛИАЛОВ: ${_branches.length}");
      }
    } catch (e) {
      print("ОШИБКА В loadBranches: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBranch(int id) async {
    final response = await _rep.deleteBranch(id);
    if (response.code == 204) {
      _branches.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}