import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../../login_screen/ui/LoginFormModel.dart';
import '../../../login_screen/ui/LoginFormScreen.dart';
import '../model/HolidaySettingsModel.dart';
import '../OwnerMainModel.dart';

class HolidaySettingsScreen extends StatefulWidget {
  const HolidaySettingsScreen({super.key});

  @override
  State<HolidaySettingsScreen> createState() => _HolidaySettingsScreenState();
}

class _HolidaySettingsScreenState extends BaseScreen<HolidaySettingsScreen, HolidaySettingsModel> {
  final List<String> weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  @override
  Widget buildBody(BuildContext context, HolidaySettingsModel viewModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text("Выберите постоянные выходные:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 15),

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

          TextField(
            controller: viewModel.holidayNoteController,
            decoration: InputDecoration(
              hintText: "Например: 31 декабря",
              filled: true,
              fillColor: AppColors.gray,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
            ),
          ),

          const SizedBox(height: 20),
          const Text("Время работы:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          TextField(
            controller: viewModel.workingHoursController,
            decoration: InputDecoration(
              hintText: "Например: 09:00 - 20:00",
              labelStyle: TextStyle(color: AppColors.blue),
              filled: true,
              fillColor: AppColors.gray,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
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

              onPressed: viewModel.isLoading ? null : () async {
                final mainModel = Provider.of<OwnerMainModel>(context, listen: false);

                if (mainModel.branches.isEmpty) {
                  await mainModel.loadBranches();
                }

                final branchIds = mainModel.branches.map((b) => b.id).toList();

                if (branchIds.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ошибка: Список филиалов пуст. Проверьте интернет."))
                  );
                  return;
                }

                await viewModel.saveGlobalSettings(branchIds, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Настройки обновлены!"))
                  );
                  mainModel.loadBranches();

                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (mounted) Navigator.of(context).maybePop();
                  });
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
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => LoginFormModel(),
                      child: const LoginScreen(),
                    ),
                  ),
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text("Выйти из аккаунта", style: TextStyle(color: Colors.red)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}