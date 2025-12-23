import 'package:medhealth/common/BaseScreenModel.dart';
import '../dto/BranchDto.dart';
import '../rep/OwnerRep.dart';

class BranchesModel extends BaseScreenModel {
  final OwnerRep _rep = OwnerRep();
  List<BranchDto> _branches = [];

  List<BranchDto> get branches => _branches;

  @override
  Future<void> onInitialization() async {
    await loadBranches();
  }

  Future<void> loadBranches() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _rep.fetchBranches();
      if (response.code == 200 && response.body is List) {
        _branches = (response.body as List)
            .map((e) => BranchDto.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Ошибка загрузки филиалов: $e");
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