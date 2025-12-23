
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../application_form/model/ApplicationFromDto.dart';
import '../../../../../styles/app_colors.dart';
import '../../ui/AdminMainModel.dart';
import 'RequestDetailsScreen.dart';// Добавьте импорт provider

class ClinicRequestsScreen extends StatelessWidget {
  const ClinicRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем модель, которая была предоставлена в AdminMainScreen
    final viewModel = Provider.of<AdminMainModel>(context); // Использование Provider

    return Scaffold(
      backgroundColor: AppColors.wight,
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (Заголовок "Список заявок")
            const Text("Список заявок", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),

            // ➡️ Отображение реального количества
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
                children: [
                  const TextSpan(text: "Количество: "),
                  TextSpan(
                    text: "${viewModel.pendingRequestsCount}", // Используем реальное количество
                    style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ➡️ Проверка на загрузку и пустой список
            if (viewModel.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (viewModel.pendingRequests.isEmpty)
              const Center(child: Text("Нет необработанных заявок"))
            else
            // ➡️ Динамический список карточек
              ...viewModel.pendingRequests.map((request) {
                return _buildRequestCard(context, request, viewModel);
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(
      BuildContext context, ApplicationFromDto request, AdminMainModel viewModel) {
    return Padding( // Добавим Padding вокруг Card для лучшего вида
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 0,
        color: AppColors.gray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outlined, color: AppColors.blue, size: 30),
          ),
          title: Text(
            // Используем имя клиники и имя заявителя для заголовка
            request.nameClinic,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue, fontSize: 18),
          ),
          subtitle: Text("Заявитель: ${request.firstName} ${request.lastName}"),

          trailing: OutlinedButton(
            onPressed: () async {
              // ➡️ Логика отказа
              await viewModel.rejectRequest(request.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Заявка от ${request.nameClinic} отклонена!")),
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            child: const Text("Отказать", style: TextStyle(fontSize: 12, color: AppColors.wight, fontWeight: FontWeight.bold)),
          ),

          onTap: () {
            // ➡️ Передаем объект заявки на экран деталей
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RequestDetailsScreen(request: request),
              ),
            );
          },
        ),
      ),
    );
  }
}