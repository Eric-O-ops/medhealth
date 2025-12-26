import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../application_form/model/ApplicationFromDto.dart';
import '../../../../../styles/app_colors.dart';
import '../../../../login_screen/dto/LoginUserDto.dart';
import '../../ui/AdminMainModel.dart';
import 'EditUserModel.dart';
import 'EditUserScreen.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем модель через Provider
    final viewModel = Provider.of<AdminMainModel>(context);

    return Scaffold(
      backgroundColor: AppColors.wight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Пользователи с правами",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
                children: [
                  const TextSpan(text: "Количество: "),
                  TextSpan(
                    text: "${viewModel.privilegedUsers.length}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Состояния загрузки и пустого списка
            if (viewModel.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (viewModel.privilegedUsers.isEmpty)
              const Center(child: Text("Нет пользователей"))
            else
              ...viewModel.privilegedUsers
                  .map((user) => _buildUserCard(context, user, viewModel))
                  .toList(),
          ],
        ),
      ),
    );
  }

  // Приватный метод для создания карточки пользователя
  Widget _buildUserCard(
      BuildContext context, LoginUserDto user, AdminMainModel viewModel) {
    return Card(
      elevation: 0,
      color: AppColors.gray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person_outlined, color: AppColors.blue, size: 30),
        ),
        title: Text(
          user.email,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.blue,
          ),
        ),
        subtitle: Text(
          "Роль: ${user.role == 'admin' ? 'Администратор' : 'Владелец'}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue, size: 30,),
              onPressed: () async {
                // ⭐️ Ждем результат (true/false), чтобы понять, нужно ли обновить список
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      // ПЕРЕДАЕМ user в модель!
                      create: (_) => EditUserModel(user: user),
                      child: EditUserScreen(user: user),
                    ),
                  ),
                );

                // Если редактирование прошло успешно, обновляем список на главном экране
                if (result == true) {
                  viewModel.loadPrivilegedUsers();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline,size: 30, color: Colors.red),
              onPressed: () {
                viewModel.deleteUser(user.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}