import 'package:medhealth/common/RAM.dart';
import '../../../common/BaseApi.dart';
import '../../../common/BaseScreenModel.dart';
import '../dto/LoginUserDto.dart';
import '../rep/LoginFormRep.dart';

class LoginFormModel extends BaseScreenModel {
  final LoginFormRep _rep = LoginFormRep();
  int? clinicOwnerId;
  int? managerBranchId;
  String email = "";
  String password = "";
  bool isHidden = true;
  LoginUserDto? currentUser;
  Future<String?> login() async {
    isLoading = true;
    notifyListeners();
    try {
      final users = await _rep.getUsers();

      final cleanEmail = email.trim();
      final cleanPassword = password.trim();

      print("Попытка входа: $cleanEmail");

      for (var user in users) {
        if (user.email.trim() == cleanEmail && user.passwordUser == cleanPassword) {
          currentUser = user;
          Ram().userId = user.id.toString();
          print("Пользователь найден! Роль: ${user.role}");
          // Логика для владельца
          if (user.role == 'owner') {
            final ownersResponse = await BaseApi().fetch("api/owners/");
            if (ownersResponse.code == 200) {
              List data = ownersResponse.body;
              final ownerData = data.firstWhere(
                    (o) => o['user']['id'] == user.id,
                orElse: () => null,
              );
              if (ownerData != null) {
                clinicOwnerId = ownerData['id'];
              }
            }
          }
          // Логика для менеджера
          if (user.role == 'manager') {
            final branchesResponse = await BaseApi().fetch("api/branches/");
            if (branchesResponse.code == 200) {
              List branches = branchesResponse.body;
              for (var branch in branches) {
                List managers = branch['managers'] ?? [];
                final isMyBranch = managers.any((m) => m['user']['id'] == user.id);
                if (isMyBranch) {
                  managerBranchId = branch['id'];
                  break;
                }
              }
            }
          }
          isLoading = false;
          notifyListeners();
          return user.role;
        }
      }
      print("Ошибка: Пользователь с таким email и паролем не найден в списке.");
    } catch (e) {
      print("Критическая ошибка при логине: $e");
    } finally {
      isLoading = false;
      notifyListeners();
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