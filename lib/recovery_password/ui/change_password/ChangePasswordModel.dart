import 'package:medhealth/common/BaseScreenModel.dart';
import 'package:medhealth/recovery_password/rep/RecoveryPasswordRep.dart';

class ChangePasswordModel extends BaseScreenModel {

  final _rep = RecoveryPasswordRep();
  final String email;

  ChangePasswordModel(this.email);

  String _password = "";
  bool _isObscurePassword = true;
  bool _isObscureRepeatPassword = true;

  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  bool get isObscurePassword => _isObscurePassword;
  set isObscurePassword (bool value) {
    _isObscurePassword = value;
    notifyListeners();
  }

  bool get isObscureRepeatPassword => _isObscureRepeatPassword;
  set isObscureRepeatPassword (bool value) {
    _isObscureRepeatPassword = value;
    notifyListeners();
  }

  void changePassword(Function() onSuccess) {
    onSuccess();
    _rep.changePassword(email, password);
  }

  @override
  Future<void> onInitialization() async {}

}