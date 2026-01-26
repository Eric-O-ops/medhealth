import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/BaseScreen.dart';
import '../../../../styles/app_colors.dart';
import '../../../login_screen/ui/LoginFormModel.dart';
import '../../../login_screen/ui/LoginFormScreen.dart';
import '../dto/DoctorDto.dart';
import '../model/DoctorsListModel.dart';
import '../model/AddDoctorModel.dart';
import '../model/FillDoctorProfileModel.dart';
import '../screens/create/CreateDoctorAccountScreen.dart';
import '../screens/DoctorShowcaseScreen.dart';
import '../screens/DoctorsListScreen.dart';
import '../screens/create/FillDoctorProfileFormScreen.dart';
import '../screens/create/FillProfileSelectorScreen.dart';
import '../screens/EditDoctorScreen.dart'; // Убедитесь, что путь верный
import 'ManagerMainModel.dart';

class ManagerMainScreen extends StatefulWidget {
  const ManagerMainScreen({super.key});

  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends BaseScreen<ManagerMainScreen, ManagerMainModel> {
  late DoctorsListModel doctorsModel;
  int _currentBranchId = 0;

  @override
  void initState() {
    super.initState();
    doctorsModel = DoctorsListModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int && args != 0) {
        setState(() {
          _currentBranchId = args;
        });
        context.read<ManagerMainModel>().setupManager(args);
        doctorsModel.setup(args);
      }
    });
  }

  List<Widget> _getScreens(ManagerMainModel viewModel) {
    return [
      // ПЕРВАЯ ВКЛАДКА: Витрина (Showcase)
      ChangeNotifierProvider.value(
        value: doctorsModel,
        child: Consumer<DoctorsListModel>(
          builder: (_, model, __) => DoctorShowcaseScreen(
            doctors: model.doctors,
            isLoading: model.isLoading,
            clinicName: viewModel.clinicName,
            branchAddress: viewModel.branchAddress,
            branchWorkingHours: model.branchWorkingHours,
            onRefresh: () => model.refreshData(),
            onEdit: (doc) => _openFillProfile(doc), // Здесь оставляем профиль (стаж/фото)
            onDelete: (id) => model.deleteDoctor(id),
          ),
        ),
      ),

      // ВТОРАЯ ВКЛАДКА: Список управления (Редактирование ФИО/Email)
      ChangeNotifierProvider.value(
        value: doctorsModel,
        child: Consumer<DoctorsListModel>(
          builder: (_, model, __) => DoctorsListScreen(
            doctors: model.doctors,
            onDelete: (id) => model.deleteDoctor(id),
            onEdit: (doctor) => _openEditAccount(doctor), // ИЗМЕНЕНО: теперь ведет на ФИО/Email
          ),
        ),
      ),

      _buildAddTab(),
    ];
  }

  // Метод для редактирования ФИО, Email и пароля
  void _openEditAccount(DoctorDto doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => AddDoctorModel()..setBranchId(_currentBranchId),
          child: EditDoctorScreen(
            doctor: doctor,
            onUpdated: () => doctorsModel.loadDoctors(),
          ),
        ),
      ),
    );
  }

  // Метод для редактирования медицинского профиля (стаж, цена, описание)
  void _openFillProfile(DoctorDto doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => FillDoctorProfileModel()..setup(doctor),
          child: const FillDoctorProfileFormScreen(),
        ),
      ),
    ).then((_) => doctorsModel.loadDoctors());
  }

  Widget _buildAddTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Column(
        children: [
          _buildSelectionCard(
            context,
            title: "Создать аккаунт",
            subtitle: "Email, пароль, ФИО",
            icon: Icons.person_add_alt_1,
            onTap: () {
              int activeBranchId = doctorsModel.branchId ?? _currentBranchId;
              if (activeBranchId == 0) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => AddDoctorModel()..setBranchId(activeBranchId),
                    child: const CreateDoctorAccountScreen(),
                  ),
                ),
              ).then((_) => doctorsModel.loadDoctors());
            },
          ),
          const SizedBox(height: 20),
          _buildSelectionCard(
            context,
            title: "Заполнить профиль",
            subtitle: "Фото, стаж, цены, график",
            icon: Icons.edit_note,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FillProfileSelectorScreen(doctors: doctorsModel.doctors),
                ),
              ).then((_) => doctorsModel.loadDoctors());
            },
          ),
          const SizedBox(height: 30),
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
        ],
      ),
    );
  }

  Widget _buildSelectionCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: AppColors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 36),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(subtitle, style: const TextStyle(fontSize: 15, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context, ManagerMainModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.wight,
      body: IndexedStack(
        index: viewModel.selectedIndex,
        children: _getScreens(viewModel),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(30),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navButton(0, Icons.location_city_outlined, viewModel),
                _navButton(1, Icons.people_outline, viewModel),
                _navButton(2, Icons.add, viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButton(int index, IconData icon, ManagerMainModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.setTabIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: viewModel.selectedIndex == index ? AppColors.blue : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.blue.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(
          icon,
          color: viewModel.selectedIndex == index ? Colors.white : AppColors.blue,
          size: 32,
        ),
      ),
    );
  }
}