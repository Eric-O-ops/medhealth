import 'package:flutter/material.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../../../../application_form/model/ApplicationFromDto.dart';
import 'AddOwners.dart';

class RequestDetailsScreen extends StatelessWidget {
  final ApplicationFromDto request; // ➡️ Принимаем объект заявки

  const RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wight,
      appBar: AppBar(
        backgroundColor: AppColors.wight,
        title: const Text(
          "Детали заявки",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Заявка от ${request.nameClinic}",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue),
              ),
            ),
            const SizedBox(height: 30),

            // ➡️ Используем реальные данные
            _buildDetailContainer("Описание:", request.description,
                isDescription: true),

            const SizedBox(height: 10),
            _buildDetailContainer("Клиника: ", request.nameClinic),
            const SizedBox(height: 10),
            _buildDetailContainer("Имя: ", request.firstName),
            const SizedBox(height: 10),
            _buildDetailContainer("Фамилия: ", request.lastName),
            const SizedBox(height: 10),
            _buildDetailContainer("Номер: ", request.phoneNumber),
            const SizedBox(height: 10),
            _buildDetailContainer("Почта: ", request.email),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // ⭐️ ИСПОЛЬЗУЕМ СТАТИЧЕСКИЙ МЕТОД CREATE, КОТОРЫЙ ВКЛЮЧАЕТ ПРОВАЙДЕР
                      // Предполагается, что AddOwnersScreen находится в AddOwners.dart
                      Navigator.of(context).push(
                        AddOwnersScreen.create(request),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Принят",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 5),
                        Icon(Icons.check_circle_outline,
                            color: Colors.white, size: 25)
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: () {
                      // ➡️ Логика отказа - просто возвращаемся назад
                      Navigator.pop(context);
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Отказать",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.cancel_outlined,
                              color: Colors.white, size: 25)
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный метод для построения контейнеров с деталями
  Widget _buildDetailContainer(String label, String value,
      {bool isDescription = false}) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 5),
            Text(value,
                style: TextStyle(
                    fontSize: isDescription ? 16 : 22,
                    color: AppColors.blue,
                    fontWeight: isDescription
                        ? FontWeight.normal
                        : FontWeight.normal)),
          ],
        ));
  }
}