import 'package:flutter/material.dart';
import 'package:medhealth/doctor/doctor_dashboard/ui/view/BookTimeDialogDoctor.dart';
import 'package:medhealth/doctor/doctor_dashboard/ui/view/DoctorTimeSlotsWidget.dart';
import 'package:medhealth/patient_appointment/dashboard/ui/view/PatientTimeSlotsWidget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/BaseScreen.dart';
import 'DoctorDashboardScreenModel.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return DoctorDashboardScreenState();
  }
}

class DoctorDashboardScreenState
    extends BaseScreen<DoctorDashboardScreen, DoctorDashboardScreenModel> {

  @override
  Widget buildBody(
    BuildContext context,
    DoctorDashboardScreenModel viewModel,
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
          else DoctorSlotsWidget(
              status: viewModel.status,
              onTimeSelected: (String time) async {

                if (viewModel.isNotFree(time)) {
                  await showDialog<AppointmentData>(
                    context: context,
                    builder: (context) {
                      return BookTimeInputDialogDoctor(
                        title: time,
                        content: " Первичные данные о пациенте.",
                        appointmentData: viewModel.getAppointmentByTime(time),
                      );
                    },
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
