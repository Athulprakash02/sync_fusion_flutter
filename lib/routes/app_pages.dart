import 'package:get/get.dart';
import 'package:sync_fusion_calendar/modules/calendar/binding/calendar_binding.dart';
import 'package:sync_fusion_calendar/modules/calendar/view/calender_screen.dart';
import 'package:sync_fusion_calendar/routes/app_routes.dart';

class AppPages {
  static var pages = [
    GetPage(
      name: AppRoutes.calnedarScreen,
      page: () => CalendarScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: CalendarBinding(),
    ),
    ];
    }