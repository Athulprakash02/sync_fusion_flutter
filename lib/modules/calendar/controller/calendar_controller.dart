import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sync_fusion_calendar/native_calender_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarController extends GetxController {
  var appointments = <Appointment>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  Future<void> loadEvents() async {
    var status = await Permission.calendar.request();

    if (status.isGranted) {
      isLoading.value = true;
      final data = await NativeCalendarService.getEvents();

      print("EVENT DATA: $data");

      final Set<String> uniqueEvents = {};
      final List<Appointment> temp = [];

      for (var e in data) {
        try {
          final start = e['start'];
          final end = e['end'];
          final title = e['title'] ?? 'No Title';

          final key = "${title}_${start}_$end";

          if (!uniqueEvents.contains(key)) {
            uniqueEvents.add(key);

            temp.add(
              Appointment(
                startTime: DateTime.fromMillisecondsSinceEpoch(
                  int.parse(start.toString()),
                ),
                endTime: DateTime.fromMillisecondsSinceEpoch(
                  int.parse(end.toString()),
                ),
                subject: title,
              ),
            );
          }
        } catch (e) {
          print("Error parsing event: $e");
        }
      }

      print("RAW COUNT: ${data.length}");
      print("UNIQUE COUNT: ${temp.length}");

      appointments.value = temp;
      isLoading.value = false;
    } else if (status.isDenied) {
      print("❌ Permission denied");
    } else if (status.isPermanentlyDenied) {
      print("⚠️ Permanently denied → opening settings");
      await openAppSettings();
    }
  }
}
