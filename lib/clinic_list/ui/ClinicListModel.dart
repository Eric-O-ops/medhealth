import 'package:medhealth/clinic_list/model/ClinicDto.dart';
import 'package:medhealth/clinic_list/rep/ClinicRep.dart';
import 'package:medhealth/common/BaseScreenModel.dart';

class ClinicListModel extends BaseScreenModel {
  final rep = ClinicRep();
  List<ClinicDto> clinics = [];

  @override
  Future<void> onInitialization() async {
    clinics = await rep.getClinics();
  }
}
