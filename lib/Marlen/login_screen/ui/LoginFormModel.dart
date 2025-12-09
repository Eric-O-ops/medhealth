import '../../../common/BaseScreenModel.dart';
import '../rep/LoginFormRep.dart';

class LoginFormModel extends BaseScreenModel {
  final LoginFormRep _rep = LoginFormRep();

  String email = "";
  String password = "";
  bool isHidden = true;

  Future<String?> login() async {
    final users = await _rep.getUsers();

    for (var user in users) {
      if (user.email == email && user.passwordUser == password) {
        return user.role; // Возвращаем роль найденного пользователя
      }
    }

    return null; // пользователь не найден
  }

  void togglePasswordVisibility() {
    isHidden = !isHidden;
    notifyListeners();
  }

  @override
  Future<void> onInitialization() async {}
}
