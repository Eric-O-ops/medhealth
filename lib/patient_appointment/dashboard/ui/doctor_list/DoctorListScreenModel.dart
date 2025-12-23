import 'package:medhealth/common/BaseScreenModel.dart' show BaseScreenModel;

import '../../dto/DoctorInfoDto.dart';
import '../../rep/PatientDashboardRep.dart';

class DoctorListScreenModel extends BaseScreenModel {

  final _rep = PatientDashboardRep();
  final List<DoctorInfoDto> doctors = [];

  @override
  Future<void> onInitialization() async {
    doctors.addAll(await _rep.fetchDoctors());
  }

}