import '../../../common/BaseApi.dart';
import '../../../common/BaseScreenModel.dart';
import '../dto/LoginUserDto.dart';
import '../rep/LoginFormRep.dart';

class LoginFormModel extends BaseScreenModel {
  final LoginFormRep _rep = LoginFormRep();
  int? clinicOwnerId;
  int? managerBranchId; // Добавляем поле для ID филиала менеджера
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
        // ЛОГИКА ДЛЯ МЕНЕДЖЕРА (Добавьте этот блок!)
        if (user.role == 'manager') {
          // Запрашиваем список всех филиалов, чтобы найти, к какому привязан этот менеджер
          final branchesResponse = await BaseApi().fetch("api/branches/");
          if (branchesResponse.code == 200) {
            List branches = branchesResponse.body;
            for (var branch in branches) {
              List managers = branch['managers'] ?? [];
              // Ищем текущего пользователя в списке менеджеров этого филиала
              final isMyBranch = managers.any((m) => m['user']['id'] == user.id);
              if (isMyBranch) {
                managerBranchId = branch['id'];
                print("Менеджер привязан к филиалу ID: $managerBranchId");
                break;
              }
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