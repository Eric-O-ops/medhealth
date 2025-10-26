import 'package:medhealth/common/BaseScreenModel.dart';

import '../../rep/RecoveryPasswordRep.dart';

class RecoveryPasswordModel extends BaseScreenModel {
  final rep = RecoveryPasswordRep();

  String email = "";

  @override
  Future<void> onInitialization() async {}

  void sentRecoveryPassword({
    required void Function() onSuccess,
    required void Function() onError,
  }) async {
    isLoading = true;

    final isExist = await rep.isUserExist(email);

    if(isExist) {
      isError = false;
      onSuccess();
    } else {
      isError = true;
      onError();
    }

    isLoading = false;
  }
}
