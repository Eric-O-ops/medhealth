import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../model/FillDoctorProfileModel.dart';

class FillDoctorProfileFormScreen extends StatefulWidget {
  const FillDoctorProfileFormScreen({super.key});

  @override
  State<FillDoctorProfileFormScreen> createState() => _FillDoctorProfileFormScreenState();
}

class _FillDoctorProfileFormScreenState extends BaseScreen<FillDoctorProfileFormScreen, FillDoctorProfileModel> {
  final _formKey = GlobalKey<FormState>();
  final List<String> weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  String? _validateEmpty(String? value) {
    if (value == null || value.isEmpty) return "Поле обязательно";
    return null;
  }

  @override
  Widget buildBody(BuildContext context, FillDoctorProfileModel viewModel) {
    if (viewModel.selectedDoctor == null) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("Профиль: ${viewModel.selectedDoctor!.lastName}"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.gray,
                      backgroundImage: viewModel.profileImage != null
                          ? FileImage(viewModel.profileImage!)
                          : null,
                      child: viewModel.profileImage == null
                          ? const Icon(Icons.person, size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => viewModel.pickImage(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text("Специальность", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: AppColors.gray, borderRadius: BorderRadius.circular(15)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: viewModel.selectedSpecialization,
                    isExpanded: true,
                    items: viewModel.specializations.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                    onChanged: (val) => viewModel.setSpecialization(val!),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: CustomTextFuild(
                      label: "Цена приема",
                      controller: viewModel.priceCtrl,
                      keyboardType: TextInputType.number,
                      validator: _validateEmpty, hintText: 'Введите цену',)),
                  const SizedBox(width: 15),
                  Expanded(child: CustomTextFuild(
                    label: "Стаж", controller:
                  viewModel.expCtrl,
                    keyboardType: TextInputType.number,
                    validator: _validateEmpty, hintText: 'лет',)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: CustomTextFuild(
                      label: "Возраст",
                      hintText: "",
                      controller: viewModel.ageCtrl,
                      keyboardType: TextInputType.number,
                      validator: _validateEmpty
                  )),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Пол", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(color: AppColors.gray, borderRadius: BorderRadius.circular(15)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: viewModel.gender,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(value: 'male', child: Text("Мужской")),
                                DropdownMenuItem(value: 'female', child: Text("Женский")),
                              ],
                              onChanged: (v) => viewModel.setGender(v!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextFuild(
                  label: "Образование",
                  hintText: "Напр: КГМА, 2015",
                  controller: viewModel.eduCtrl,
                  validator: _validateEmpty // Не даст сохранить, если пусто
              ),

              CustomTextFuild(
                  label: "О себе",
                  hintText: "Краткое описание опыта и достижений",
                  controller: viewModel.descCtrl,
                  maxLines: 3,
                  validator: _validateEmpty // Проверка на пустоту
              ),
             const Divider(height: 30),
              const Text("Рабочие дни врача", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text("Серые дни — выходные филиала", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: weekDays.map((day) {
                  List<String> disabledList = viewModel.branchOffDays.split(",").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                  bool isBranchClosed = disabledList.contains(day);
                  bool isSelected = isBranchClosed ? false : viewModel.selectedWorkDays.contains(day);

                  return GestureDetector(
                    onTap: isBranchClosed ? null : () => viewModel.toggleWorkDay(day),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isBranchClosed
                            ? Colors.grey.shade300
                            : (isSelected ? AppColors.blue : AppColors.gray),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isBranchClosed
                              ? Colors.grey.shade600
                              : (isSelected ? Colors.white : Colors.black),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  // В методе buildBody у ElevatedButton:

                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      viewModel.saveProfile(() {
                        // СООБЩЕНИЕ ОБ УСПЕХЕ
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Профиль успешно обновлен!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Сохранить профиль", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}