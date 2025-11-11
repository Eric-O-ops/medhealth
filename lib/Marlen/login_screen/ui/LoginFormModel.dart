import '../../../common/BaseScreenModel.dart';
import '../rep/LoginFormRep.dart';

class LoginFormModel extends BaseScreenModel {
  final LoginFormRep _rep = LoginFormRep();

  String email = "";
  String password = "";
  bool isHidden = true;

  Future<String?> login() async {
    final owners = await _rep.getOwners();
    for (var owner in owners) {
      if (owner.email == email && owner.passwordUser == password) {
        return owner.role;
      }
    }
    return null;
  }

  void togglePasswordVisibility() {
    isHidden = !isHidden;
    notifyListeners();
  }

  @override
  Future<void> onInitialization() async {}
}
