import 'package:flutter/material.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../../manager_main_screen/dto/DoctorDto.dart';
import '../../manager_main_screen/rep/ManagerRep.dart';

class PatientDoctorsListScreen extends StatefulWidget {
  final int branchId;
  final String address;

  const PatientDoctorsListScreen({
    super.key,
    required this.branchId,
    required this.address,
  });

  @override
  State<PatientDoctorsListScreen> createState() => _PatientDoctorsListScreenState();
}

class _PatientDoctorsListScreenState extends State<PatientDoctorsListScreen> {
  final ManagerRep _rep = ManagerRep();
  List<DoctorDto> _doctors = [];
  bool _isLoading = true;
  String _clinicName = "Загрузка...";
  String _branchWorkingHours = "Не указано"; // Добавили поле времени

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _rep.setBranchId(widget.branchId);

    // Параллельная загрузка данных
    final branchRes = await _rep.fetchBranchInfo();
    final doctorsRes = await _rep.fetchMyDoctors();

    if (mounted) {
      setState(() {
        if (branchRes.code == 200) {
          _clinicName = branchRes.body['name_clinic'] ?? "Клиника";
          // Берем время работы напрямую из филиала
          _branchWorkingHours = branchRes.body['working_hours'] ?? "Не указано";
        }
        if (doctorsRes.code == 200 && doctorsRes.body is List) {
          _doctors = (doctorsRes.body as List).map((e) => DoctorDto.fromJson(e)).toList();
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Выбор врача", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadData(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildBranchHeader(),
            _buildCounter(),
            if (_doctors.isEmpty)
              const Center(child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text("В данном филиале пока нет врачей"),
              ))
            else
              ..._doctors.map((doctor) => _buildFullPatientDoctorCard(doctor)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchHeader() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.business, size: 20, color: AppColors.blue),
            const SizedBox(width: 8),
            Text("Клиника: $_clinicName", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ]),
          const SizedBox(height: 5),
          Row(children: [
            const Icon(Icons.location_on, size: 20, color: Colors.grey),
            const SizedBox(width: 8),
            Text("Филиал: ${widget.address}", style: const TextStyle(color: Colors.grey)),
          ]),
        ],
      ),
    );
  }

  Widget _buildCounter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text("Доступно врачей: ${_doctors.length}",
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue)),
    );
  }

  Widget _buildFullPatientDoctorCard(DoctorDto doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 70, height: 70,
                  child: doctor.photoUrl != null && doctor.photoUrl!.isNotEmpty
                      ? Image.network(doctor.photoUrl!, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 40, color: AppColors.blue))
                      : const Icon(Icons.person, size: 40, color: AppColors.blue),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${doctor.firstName} ${doctor.lastName}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(doctor.specialization, style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoTile("Цена", "${doctor.price} сом"),
              _infoTile("Стаж", "${doctor.experience} лет"),
              _infoTile("Возраст", "${doctor.age} лет"),
              // ИСПРАВЛЕНО: Отображение пола
              _infoTile("Пол", doctor.gender == 'male' ? "Мужской" : "Женский"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _iconDetail(Icons.calendar_month, "Рабочие дни", doctor.offDays.isEmpty ? "Не указаны" : doctor.offDays)),
              Expanded(child: _iconDetail(Icons.access_time, "Часы работы", _branchWorkingHours)),
            ],
          ),
          const SizedBox(height: 15),
          _textSection("Образование", doctor.education),
          const SizedBox(height: 10),
          _textSection("О себе", doctor.description),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Навигация на выбор даты
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              child: const Text("Записаться на прием", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(children: [
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue, fontSize: 14)),
    ]);
  }

  Widget _iconDetail(IconData icon, String label, String value) {
    return Row(children: [
      Icon(icon, size: 18, color: AppColors.blue),
      const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
      ])),
    ]);
  }

  Widget _textSection(String title, String content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
      const SizedBox(height: 2),
      Text(content.isEmpty ? "Информация отсутствует" : content, style: const TextStyle(fontSize: 13, color: Colors.black54)),
    ]);
  }
}