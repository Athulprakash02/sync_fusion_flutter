package com.example.sync_fusion_calendar

import android.database.Cursor
import android.provider.CalendarContract
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "calendar_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "getEvents") {

                    val events = mutableListOf<Map<String, String>>()

                    val cursor: Cursor? = contentResolver.query(
                        CalendarContract.Events.CONTENT_URI,
                        arrayOf(
                            CalendarContract.Events.TITLE,
                            CalendarContract.Events.DTSTART,
                            CalendarContract.Events.DTEND
                        ),
                        null,
                        null,
                        null
                    )

                    cursor?.use {
                        while (it.moveToNext()) {
                            val title = it.getString(0)
                            val start = it.getLong(1)
                            val end = it.getLong(2)

                            events.add(
                                mapOf(
                                    "title" to title,
                                    "start" to start.toString(),
                                    "end" to end.toString()
                                )
                            )
                        }
                    }

                    result.success(events)
                } else {
                    result.notImplemented()
                }
            }
    }
}