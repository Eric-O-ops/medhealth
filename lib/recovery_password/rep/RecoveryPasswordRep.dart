import '../api/RecoveryPasswordApi.dart';

class RecoveryPasswordRep {
  final RecoveryPasswordApi api = RecoveryPasswordApi();

  Future<bool> isUserExist(String email) async {
    final response = await api.fetchUsers(email);

    if (response.code == 200) {
      final users = response.body as List<dynamic>;
      bool isFounded = false;

      for (var user in users) {
        if (user['email'] == email) {
          isFounded = true;
        }
      }

      return isFounded;
    } else {
      return false;
    }
  }

  Future<bool> changePassword(String email, String password) async {
    final body = await api.fetchUsers(email);
    final users = body.body as List<dynamic>;
    late String id;


    for (var user in users) {
      if (user['email'] == email) {
          id = user['id'].toString();
      }
    }

    final response = await api.changePassword(id, password);

    if (response.code == 200) {
      return true;
    } else {
      return false;
    }
  }

}
