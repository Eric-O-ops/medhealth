import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/view/CustomTextField.dart';
import '../../../../styles/app_colors.dart';
import '../../../../common/RAM.dart';
import '../../../login_screen/ui/LoginFormModel.dart';
import '../../../login_screen/ui/LoginFormScreen.dart';
import '../models/PatientProfileModel.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Ram().userId;
      if (userId != null && userId.isNotEmpty) {
        context.read<PatientProfileModel>().onInitialization();
      }
    });
  }

  Future<void> _selectDate(BuildContext context, PatientProfileModel viewModel) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.blue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      viewModel.dobCtrl.text =
      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PatientProfileModel>();
    final userId = Ram().userId;

    if (userId == null || userId.isEmpty) {
      return _buildGuestState();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildPhotoBlock(viewModel),
              const SizedBox(height: 30),
              CustomTextFuild(
                label: "Имя",
                hintText: "Введите имя",
                controller: viewModel.firstNameCtrl,
                validator: (v) => (v == null || v.isEmpty) ? "Заполните имя" : null,
              ),
              const SizedBox(height: 15),
              CustomTextFuild(
                label: "Фамилия",
                hintText: "Введите фамилию",
                controller: viewModel.lastNameCtrl,
                validator: (v) => (v == null || v.isEmpty) ? "Заполните фамилию" : null,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => _selectDate(context, viewModel),
                child: AbsorbPointer(
                  child: CustomTextFuild(
                    label: "Дата рождения",
                    hintText: "Выберите дату",
                    controller: viewModel.dobCtrl,
                    validator: (v) => (v == null || v.isEmpty) ? "Заполните дату рождения" : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Пол",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: viewModel.gender,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: AppColors.gray),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: AppColors.gray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: AppColors.blue, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: const [
                      DropdownMenuItem(value: 'male', child: Text("Мужской")),
                      DropdownMenuItem(value: 'female', child: Text("Женский")),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => viewModel.gender = val);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const SizedBox(height: 10),
              CustomTextFuild(
                label: "Телефон",
                hintText: "0XXXXXXXXX",
                controller: viewModel.phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty) ? "Заполните телефон" : null,
              ),
              const SizedBox(height: 15),
              CustomTextFuild(
                label: "Адрес",
                hintText: "Ваш адрес",
                controller: viewModel.addressCtrl,
                validator: (v) => (v == null || v.isEmpty) ? "Заполните адрес" : null,
              ),
              const SizedBox(height: 40),
              _buildSaveButton(viewModel),
              const SizedBox(height: 10),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Остальные вспомогательные методы без изменений...
  Widget _buildGuestState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle_outlined, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text("Вы вошли как гость", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Зарегистрируйтесь, чтобы записываться к врачам и управлять своим профилем",
                textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                onPressed: _goToLogin,
                child: const Text("Войти / Регистрация",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoBlock(PatientProfileModel viewModel) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: AppColors.gray,
            backgroundImage: viewModel.profileImage != null
                ? FileImage(viewModel.profileImage!)
                : (viewModel.photoUrl != null && viewModel.photoUrl!.isNotEmpty
                ? NetworkImage(viewModel.photoUrl!)
                : null) as ImageProvider?,
            child: (viewModel.profileImage == null && (viewModel.photoUrl == null || viewModel.photoUrl!.isEmpty))
                ? const Icon(Icons.person, size: 65, color: Colors.grey)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: viewModel.pickImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(PatientProfileModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            viewModel.saveProfile(() {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Профиль успешно обновлен"), backgroundColor: Colors.green));
            });
          }
        },
        child: const Text("Сохранить изменения",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: TextButton.icon(
        onPressed: _goToLogin,
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text("Выйти из аккаунта", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
      ),
    );
  }

  void _goToLogin() {
    Ram().userId = "";
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => LoginFormModel(),
          child: const LoginScreen(),
        ),
      ),
          (route) => false,
    );
  }
}