import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sync_fusion_calendar/constants/app_strings.dart';
import 'package:sync_fusion_calendar/routes/app_pages.dart';
import 'package:sync_fusion_calendar/routes/app_routes.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        title: AppStrings.appName,
        initialRoute: AppRoutes.calnedarScreen,
        getPages: AppPages.pages,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
       
      );
  }
}