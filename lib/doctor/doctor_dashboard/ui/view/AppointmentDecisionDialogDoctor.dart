import 'package:flutter/material.dart';

import 'PatientAppointmentStatus.dart';

class AppointmentDecisionDialogDoctor extends StatelessWidget {
  final String title;
  final AppointmentFullData data;
  final VoidCallback onNoShow;
  final VoidCallback onCompleted;

  const AppointmentDecisionDialogDoctor({
    super.key,
    required this.title,
    required this.data,
    required this.onNoShow,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(data.status);

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 📅 Дата
            _InfoRow(label: "Дата", value: data.date),

            /// ⏰ Время
            _InfoRow(label: "Время", value: data.time),

            const SizedBox(height: 8),

            /// 🟢 Статус
            Row(
              children: [
                const Text(
                  "Статус: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    getStatusText(data.status),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 🩺 Симптомы
            const Text(
              "Описание симптомов",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data.symptomsDescription),

            const SizedBox(height: 12),

            /// 💊 Самолечение
            const Text(
              "Принятые методы самолечения",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data.selfTreatmentMethodsTaken),
          ],
        ),
      ),
      actions: [
        Column(
          children: [
            if (data.status == PatientAppointmentStatus.scheduled) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onNoShow();
                  },
                  child: const Text(
                    "Пациент не пришел на приём",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onCompleted();
                  },
                  child: const Text(
                    "Отметить приём завершённым",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Закрыть"),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class AppointmentFullData {
  late final String date;
  late final String time;
  late final PatientAppointmentStatus status;
  late final String symptomsDescription;
  late final String selfTreatmentMethodsTaken;

  AppointmentFullData({
    required this.date,
    required this.time,
    required this.status,
    required this.symptomsDescription,
    required this.selfTreatmentMethodsTaken,
  });

  AppointmentFullData.empty() {
    date = "";
    time = "";
    status = PatientAppointmentStatus.free;
    symptomsDescription = "";
    selfTreatmentMethodsTaken = "";
  }
}

String getStatusText(PatientAppointmentStatus status) {
  switch (status) {
    case PatientAppointmentStatus.no_show:
      return "Пациент не пришёл";
    case PatientAppointmentStatus.scheduled:
      return "Запланирован";
    case PatientAppointmentStatus.completed:
      return "Приём завершён";
    case PatientAppointmentStatus.free:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

Color getStatusColor(PatientAppointmentStatus status) {
  switch (status) {
    case PatientAppointmentStatus.no_show:
      return Colors.red;
    case PatientAppointmentStatus.scheduled:
      return Colors.orange;
    case PatientAppointmentStatus.completed:
      return Colors.purple;
    case PatientAppointmentStatus.free:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}
