import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhealth/styles/app_colors.dart';
import '../models/MyAppointmentsModel.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyAppointmentsModel>().onInitialization();
    });
  }

  void _confirmCancellation(BuildContext context, dynamic apt, MyAppointmentsModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Отмена записи", style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text("Вы уверены, что хотите отменить эту запись?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Назад", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                viewModel.cancelBooking(apt);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Запись отменена"),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text("Да, отменить", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyAppointmentsModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Мои визиты", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => viewModel.loadAppointments(),
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.appointments.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          itemCount: viewModel.appointments.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => _buildAppointmentCard(viewModel.appointments[index], viewModel),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        const Center(
          child: Column(
            children: [
              Icon(Icons.event_note, size: 60, color: Colors.grey),
              SizedBox(height: 10),
              Text("У вас пока нет записей", style: TextStyle(color: Colors.grey, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(dynamic apt, MyAppointmentsModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Инфо о враче (без аватара)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apt['doctor_name'] ?? "Врач",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      apt['specialization'] ?? "Специалист",
                      style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(apt['status']),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, thickness: 1, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Дата и время
              Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.blue),
                  const SizedBox(width: 6),
                  Text(apt['date'] ?? "", style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time_rounded, size: 16, color: AppColors.blue),
                  const SizedBox(width: 6),
                  Text(apt['time'] ?? "", style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              // Новая иконка удаления (корзина)
              if (apt['status'] == 'scheduled')
                GestureDetector(
                  onTap: () => _confirmCancellation(context, apt, viewModel),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    bool isScheduled = status == 'scheduled';
    String label = isScheduled ? "Ожидается" : "Завершено";
    Color color = isScheduled ? Colors.green : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}