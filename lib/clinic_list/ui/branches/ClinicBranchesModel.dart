import 'package:medhealth/clinic_list/model/BranchesAndSpecialtyDto.dart';
import 'package:medhealth/clinic_list/rep/ClinicRep.dart';
import 'package:medhealth/common/BaseScreenModel.dart';

class ClinicBranchesModel extends BaseScreenModel {
  final int idOwner;
  final String nameClinic;
  late final List<BranchesAndSpecialtyDto> listBranches;

  ClinicBranchesModel(this.idOwner, this.nameClinic);
  final rep = ClinicRep();


  @override
  Future<void> onInitialization() async {
    listBranches = await rep.getSpecializationsClinic(nameClinic);
  }

}