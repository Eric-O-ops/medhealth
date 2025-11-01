import 'package:medhealth/clinic_owner_screens/model/BranchesDto.dart';
import 'package:medhealth/clinic_owner_screens/rep/ClinicOwnerRep.dart';
import 'package:medhealth/common/BaseScreenModel.dart';

class BranchesModel extends BaseScreenModel {
  final _rep = ClinicOwnerRep();
  late List<BranchDto> _branches;

  List<BranchDto> get branches => _branches;

  @override
  Future<void> onInitialization() async {
    _branches = await _rep.getBranches();
  }

  Future<void> updateBranchesAddress(int id, String address) async {
    final result = await _rep.updateAddressBranch(id, address);

    if(result == true) {
      _branches = await _rep.getBranches();
      notifyListeners();
    }

  }

  Future<void> removeBranches(int id) async {
    final result = await _rep.deleteBranches(id);

    if(result == true) {
      _branches = await _rep.getBranches();
      notifyListeners();
    }

  }

}
