import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Добавлено для связи с OwnerMainModel
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../model/HolidaySettingsModel.dart';
import '../OwnerMainModel.dart'; // Добавь этот импорт, чтобы экран видел главную модель

class HolidaySettingsScreen extends StatefulWidget {
  const HolidaySettingsScreen({super.key});

  @override
  State<HolidaySettingsScreen> createState() => _HolidaySettingsScreenState();
}

class _HolidaySettingsScreenState extends BaseScreen<HolidaySettingsScreen, HolidaySettingsModel> {
  final List<String> weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  @override
  Widget buildBody(BuildContext context, HolidaySettingsModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Настройки выходных", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Выберите постоянные выходные:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),

            // Выбор дней недели (Chips)
            Wrap(
              spacing: 10,
              children: weekDays.map((day) {
                final isSelected = viewModel.selectedDays.contains(day);
                return FilterChip(
                  label: Text(day),
                  selected: isSelected,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  selectedColor: AppColors.blue,
                  checkmarkColor: Colors.white,
                  onSelected: (_) => viewModel.toggleDay(day),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            const Text("Предстоящий праздник:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),

            // Поле для ввода текста праздника
            TextField(
              controller: viewModel.holidayNoteController,
              decoration: InputDecoration(
                hintText: "Например: 8 Марта",
                filled: true,
                fillColor: AppColors.gray,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Кнопка сохранения
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                onPressed: viewModel.isLoading ? null : () {
                  // Достаем список филиалов из главной модели владельца
                  final mainModel = Provider.of<OwnerMainModel>(context, listen: false);
                  final branchIds = mainModel.branches.map((b) => b.id).toList();

                  if (branchIds.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ошибка: У вас пока нет филиалов"))
                    );
                    return;
                  }

                  // Вызываем сохранение
                  viewModel.saveGlobalSettings(branchIds, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Настройки применены ко всем филиалам"))
                    );
                    // Обновляем список филиалов, чтобы изменения сразу отобразились на главной
                    mainModel.loadBranches();
                  });
                },
                child: viewModel.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Сохранить для всех филиалов",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 30),

            // Кнопка выхода
            Center(
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text("Выйти из аккаунта", style: TextStyle(color: Colors.red)),
              ),
            )
          ],
        ),
      ),
    );
  }
}