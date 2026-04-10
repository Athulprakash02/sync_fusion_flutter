import 'package:flutter/services.dart';

class NativeCalendarService {
  static const platform = MethodChannel('calendar_channel');

  static Future<List<dynamic>> getEvents() async {
    final events = await platform.invokeMethod('getEvents');
    return events;
  }
}