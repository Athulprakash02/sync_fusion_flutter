import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sync_fusion_calendar/constants/app_strings.dart';
import 'package:sync_fusion_calendar/data/data_source.dart';
import 'package:sync_fusion_calendar/modules/calendar/controller/calendar_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart'
    hide CalendarController;

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});
  final CalendarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.deviceCalendarEvents),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.appointments.isEmpty) {
          return const Center(
            child: Text(
              AppStrings.noEventsFound,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return SfCalendar(
          view: CalendarView.month,
          todayHighlightColor: Colors.blue,
          showNavigationArrow: true,
          dataSource: MeetingDataSource(controller.appointments),

          appointmentBuilder: (context, details) {
            final appointment = details.appointments.first;

            return Container(
              // margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                appointment.subject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },

          monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            agendaViewHeight: 200,
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
          ),

          scheduleViewSettings: const ScheduleViewSettings(
            appointmentTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }),
    );
  }
}
