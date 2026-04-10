import 'package:get/get.dart';
import 'package:sync_fusion_calendar/modules/calendar/controller/calendar_controller.dart';

class CalendarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}