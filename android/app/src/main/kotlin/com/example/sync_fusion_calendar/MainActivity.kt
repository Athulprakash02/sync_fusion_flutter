package com.example.sync_fusion_calendar

import android.database.Cursor
import android.provider.CalendarContract
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {

    private val CHANNEL = "calendar_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "getEvents") {
                    val events = getCalendarEvents()
                    result.success(events)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun getCalendarEvents(): List<Map<String, Any?>> {
        val eventList: MutableList<Map<String, Any?>> = ArrayList()

        val projection = arrayOf(
            CalendarContract.Events.TITLE,
            CalendarContract.Events.DTSTART,
            CalendarContract.Events.DTEND
        )

        val cursor: Cursor? = contentResolver.query(
            CalendarContract.Events.CONTENT_URI,
            projection,
            null,
            null,
            null
        )

        cursor?.use {
            val titleIndex = it.getColumnIndex(CalendarContract.Events.TITLE)
            val startIndex = it.getColumnIndex(CalendarContract.Events.DTSTART)
            val endIndex = it.getColumnIndex(CalendarContract.Events.DTEND)

            while (it.moveToNext()) {
                val event: MutableMap<String, Any?> = HashMap()

                event["title"] = it.getString(titleIndex)
                event["start"] = it.getLong(startIndex).toString()
                event["end"] = it.getLong(endIndex).toString()

                eventList.add(event)
            }
        }

        return eventList
    }
}