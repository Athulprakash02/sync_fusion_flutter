import 'package:get/get.dart';
import 'package:sync_fusion_calendar/native_calender_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarController extends GetxController {
  var appointments = <Appointment>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  Future<void> loadEvents() async {
    final data = await NativeCalendarService.getEvents();

    final List<Appointment> temp = [];

    for (var e in data) {
      temp.add(
        Appointment(
          startTime: DateTime.fromMillisecondsSinceEpoch(int.parse(e['start'])),
          endTime: DateTime.fromMillisecondsSinceEpoch(int.parse(e['end'])),
          subject: e['title'] ?? 'No Title',
        ),
      );
    }

    appointments.value = temp;
  }
}