import 'package:flutter/material.dart';

class AppointmentData {
  final String symptomsDescription;
  final String selfTreatmentMethodsTaken;

  AppointmentData({
    required this.symptomsDescription,
    required this.selfTreatmentMethodsTaken,
  });
}

class BookTimeInputDialogDoctor extends StatelessWidget {
  final String title;
  final String content;
  final AppointmentData appointmentData;

  const BookTimeInputDialogDoctor({
    super.key,
    required this.title,
    required this.content,
    required this.appointmentData,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content),
            const SizedBox(height: 20),

            Text("Описание симптомов"),
            Text(appointmentData.symptomsDescription),

            SizedBox(height: 10),

            Text("Принятые методы самолечения"),
            Text(appointmentData.selfTreatmentMethodsTaken),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
