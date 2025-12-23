import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/view/CustomTextField.dart'; // ⭐️ Теперь это класс
import 'package:medhealth/styles/app_colors.dart';
import '../../../../../application_form/model/ApplicationFromDto.dart';
import 'AddOwnersModel.dart';
import 'package:medhealth/common/view/CommonCompliteScreen.dart';


class AddOwnersScreen extends StatefulWidget {
  final ApplicationFromDto request;

  const AddOwnersScreen({super.key, required this.request});

  static Route<void> create(ApplicationFromDto request) {
    return MaterialPageRoute<void>(
      builder: (context) => ChangeNotifierProvider(
        create: (_) => AddOwnersModel(request: request),
        child: AddOwnersScreen(request: request),
      ),
    );
  }

  @override
  State<AddOwnersScreen> createState() => _AddOwnersScreenState();
}

class _AddOwnersScreenState extends BaseScreen<AddOwnersScreen, AddOwnersModel> {
  final _formKey = GlobalKey<FormState>();

  // ⭐️ ДОБАВЛЕНО: createModel, так как BaseScreen его требует
  @override
  AddOwnersModel createModel() => AddOwnersModel(request: widget.request);


  @override
  Widget buildBody(BuildContext context, AddOwnersModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.wight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text("Добавить клинику",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 30),

              // ⭐️ ДОБАВЛЕНЫ ДЕТАЛИ ЗАЯВКИ для контекста
              _buildInfoTile("Клиника:", viewModel.request.nameClinic),
              _buildInfoTile("Заявитель:", "${viewModel.request.firstName} ${viewModel.request.lastName}"),
              const SizedBox(height: 30),
              Text("Создайте логин и пароль для владельца частной клиники",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10),

              // Поле Почта (предзаполнено)
              CustomTextFuild( // ⭐️ Теперь это класс
                label: "Почта",
                hintText: "Введите почту",
                controller: viewModel.emailController, // ⭐️ ИСПОЛЬЗУЕМ КОНТРОЛЛЕР
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || !value.contains('@')) ? 'Некорректная почта' : null,
                onChanged: null, // ⭐️ УДАЛЕНО: onChanged не нужен при использовании controller
              ),

              // Поле Пароль
              CustomTextFuild( // ⭐️ Теперь это класс
                label: "Пароль",
                hintText: "Введите пароль",
                controller: viewModel.passwordController, // ⭐️ ИСПОЛЬЗУЕМ КОНТРОЛЛЕР
                validator: (value) => (value == null || value.length < 6) ? 'Минимум 6 символов' : null,
                onChanged: null, // ⭐️ УДАЛЕНО: onChanged не нужен
              ),


              const SizedBox(height: 60),

              // Кнопка Добавить
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: AppColors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  onPressed: viewModel.isLoading ? null : () {
                    if (_formKey.currentState!.validate()) {
                      // Проверка на пустоту происходит внутри модели
                      viewModel.createOwnerAndClinic(
                        onSuccess: () {
                          // Переход на экран успеха
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonCompleteScreen(title: "Клиника и владелец успешно добавлены!"),
                            ),
                                (Route<dynamic> route) => route.isFirst,
                          );
                        },
                        onError: (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка: $error')));
                        },
                      );
                    }
                  },
                  child: viewModel.isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text("Добавить", style: TextStyle(color: AppColors.wight, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Вспомогательный виджет для вывода информации
  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16, color: AppColors.blue))),
        ],
      ),
    );
  }
}