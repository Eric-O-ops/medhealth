import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ManagerMainModel.dart';

class ManagerMainScreen extends StatefulWidget {
  final int userId; // ID авторизованного пользователя
  const ManagerMainScreen({super.key, required this.userId});

  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends State<ManagerMainScreen> {
  @override
  Widget build(BuildContext context) {
    // Используем ChangeNotifierProvider для связки модели и UI
    return ChangeNotifierProvider(
      create: (_) => ManagerMainModel()..initManager(widget.userId),
      child: Consumer<ManagerMainModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Управление врачами")),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showDoctorDialog(context, model, isEditing: false),
              child: const Icon(Icons.add),
            ),
            body: model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : model.doctors.isEmpty
                ? const Center(child: Text("Врачей пока нет"))
                : ListView.builder(
              itemCount: model.doctors.length,
              itemBuilder: (context, index) {
                final doc = model.doctors[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text("${doc.firstName} ${doc.lastName}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Спец: ${doc.specialization}"),
                        Text("Опыт: ${doc.experience} лет"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => model.deleteDoctor(doc.userId),
                    ),
                    onTap: () {
                      // Заполнение полей для редактирования (упрощенно)
                      model.educationCtrl.text = doc.education;
                      model.descCtrl.text = doc.description;
                      model.expCtrl.text = doc.experience.toString();
                      _showDoctorDialog(context, model, isEditing: true, docId: doc.id);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Диалоговое окно для добавления/редактирования
  void _showDoctorDialog(BuildContext context, ManagerMainModel model, {required bool isEditing, int? docId}) {
    if (!isEditing) model.clearFields();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? "Редактировать" : "Добавить врача"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isEditing) ...[
                TextField(controller: model.emailCtrl, decoration: const InputDecoration(labelText: "Email (Логин)")),
                TextField(controller: model.passwordCtrl, decoration: const InputDecoration(labelText: "Пароль")),
                TextField(controller: model.firstNameCtrl, decoration: const InputDecoration(labelText: "Имя")),
                TextField(controller: model.lastNameCtrl, decoration: const InputDecoration(labelText: "Фамилия")),
                TextField(controller: model.phoneCtrl, decoration: const InputDecoration(labelText: "Телефон")),
              ],
              const SizedBox(height: 10),
              TextField(controller: model.educationCtrl, decoration: const InputDecoration(labelText: "Образование")),
              TextField(controller: model.expCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Стаж (лет)")),
              TextField(controller: model.descCtrl, maxLines: 3, decoration: const InputDecoration(labelText: "О себе")),
              // Тут можно добавить DropdownButton для выбора специальности
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена")),
          ElevatedButton(
            onPressed: () {
              model.saveDoctor(
                isEditing: isEditing,
                docId: docId,
                onSuccess: () => Navigator.pop(ctx),
              );
            },
            child: const Text("Сохранить"),
          )
        ],
      ),
    );
  }
}