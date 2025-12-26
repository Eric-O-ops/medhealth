import '../../../common/BaseApi.dart';
import '../../../common/BaseScreenModel.dart';
import '../dto/LoginUserDto.dart';
import '../rep/LoginFormRep.dart';

class LoginFormModel extends BaseScreenModel {
  final LoginFormRep _rep = LoginFormRep();
  int? clinicOwnerId;

  String email = "";
  String password = "";
  bool isHidden = true;
  LoginUserDto? currentUser;

  Future<String?> login() async {
    final users = await _rep.getUsers();

    for (var user in users) {
      if (user.email == email && user.passwordUser == password) {
        currentUser = user;

        // Если это владелец, ищем его clinic_owner_id
        if (user.role == 'owner') {
          final ownersResponse = await BaseApi().fetch("api/owners/");
          if (ownersResponse.code == 200) {
            List data = ownersResponse.body;
            // Ищем запись в owners, где user.id совпадает с текущим пользователем
            final ownerData = data.firstWhere(
                  (o) => o['user']['id'] == user.id,
              orElse: () => null,
            );
            if (ownerData != null) {
              clinicOwnerId = ownerData['id'];
              print("Найден ID клиники: $clinicOwnerId");
            }
          }
        }
        return user.role;
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