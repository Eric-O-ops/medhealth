import 'package:flutter/material.dart';
import 'package:medhealth/doctor/doctor_dashboard/ui/view/BookTimeDialogDoctor.dart' show AppointmentData;

Widget BookTimeDialogPatient({
  required String title,
  required String content,
  required BuildContext context,
  required String acceptText,
  required bool isShowNegative,
  Function()? onAccept,
}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isShowNegative)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Отмена"),
            ),

          TextButton(
            onPressed: () {
              onAccept?.call();
              Navigator.pop(context);
            },
            child: Text(acceptText),
          ),
        ],
      ),
    ],
  );
}

class BookTimeInputDialogPatient extends StatefulWidget {
  final String title;
  final String content;
  final String acceptText;

  const BookTimeInputDialogPatient({
    super.key,
    required this.title,
    required this.content,
    required this.acceptText,
  });

  @override
  State<BookTimeInputDialogPatient> createState() => _BookTimeInputDialogPatientState();
}

class _BookTimeInputDialogPatientState extends State<BookTimeInputDialogPatient> {
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();

  @override
  void dispose() {
    _symptomsController.dispose();
    _treatmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.content),
            const SizedBox(height: 20),

            TextFormField(
              controller: _symptomsController,
              decoration: const InputDecoration(
                labelText: 'Описание симптомов',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _treatmentController,
              decoration: const InputDecoration(
                labelText: 'Принятые методы самолечения',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Отмена"),
            ),

            TextButton(
              onPressed: () {
                final resultData = AppointmentData(
                  symptomsDescription: _symptomsController.text,
                  selfTreatmentMethodsTaken: _treatmentController.text,
                );

                Navigator.pop(context, resultData);
              },
              child: Text(widget.acceptText),
            ),
          ],
        ),
      ],
    );
  }
}
