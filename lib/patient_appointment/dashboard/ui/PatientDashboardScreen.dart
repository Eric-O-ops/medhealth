import 'package:flutter/material.dart';
import 'package:medhealth/doctor/doctor_dashboard/ui/view/BookTimeDialogDoctor.dart';
import 'package:medhealth/patient_appointment/dashboard/ui/view/BookTimeDialogPatient.dart';
import 'package:medhealth/patient_appointment/dashboard/ui/view/PatientTimeSlotsWidget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/BaseScreen.dart';
import 'PatientDashboardScreenModel.dart';

class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return PatientDashboardScreenState();
  }
}

class PatientDashboardScreenState
    extends BaseScreen<PatientDashboardScreen, PatientDashboardScreenModel> {

  @override
  Widget buildBody(
    BuildContext context,
    PatientDashboardScreenModel viewModel,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: viewModel.focusedDay,
              selectedDayPredicate: (day) =>
                  isSameDay(viewModel.selectedDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  viewModel.selectedDay = selected;
                  viewModel.focusedDay = focused;
                });

                viewModel.setDoctorAppointmentsUi(selected);
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),

              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),

                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          if (viewModel.isLoading) CircularProgressIndicator()
          else PatientSlotsWidget(
              status: viewModel.status,
              onTimeSelected: (String time) async {

                if (viewModel.isNotBusyOrMine(time)) {
                  final AppointmentData? inputData = await showDialog<AppointmentData>(
                    context: context,
                    builder: (context) {
                      return BookTimeInputDialogPatient(
                        title: time,
                        content: "Пожалуйста, опишите симптомы и методы самолечения.",
                        acceptText: 'Записаться',
                      );
                    },
                  );

                  if (inputData != null) {
                    viewModel.symptomsDescription = inputData.symptomsDescription;
                    viewModel.selfTreatmentMethodsTaken = inputData.selfTreatmentMethodsTaken;

                    viewModel.setMineStatusRegistration(time);
                  }

                } else {
                  if (viewModel.isMine(time)) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BookTimeDialogPatient(
                          title: "Вы заняли это время",
                          content: "Хотите удалить запись ?",
                          context: context,
                          acceptText: 'Да',
                          isShowNegative: true,
                          onAccept: () async {
                            viewModel.removePatientAppointment(time);
                          }
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BookTimeDialogPatient(
                          title: "Время занято",
                          content: "На это время уже есть запись",
                          context: context,
                          acceptText: 'Ок',
                          isShowNegative: false,
                        );
                      },
                    );
                  }
                }
              },
            ),
        ],
      ),
    );
  }
}
