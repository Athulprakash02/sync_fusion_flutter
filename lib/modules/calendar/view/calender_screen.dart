import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sync_fusion_calendar/data/data_source.dart';
import 'package:sync_fusion_calendar/modules/calendar/controller/calendar_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' hide CalendarController;

class CalendarScreen extends StatelessWidget {
   CalendarScreen({super.key});
 final CalendarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Device Calendar Events')),
      body: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(controller.appointments),
          monthViewSettings: MonthViewSettings(
            showAgenda: true,
          ),
        )
    );
  }
}