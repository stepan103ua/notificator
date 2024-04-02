package com.example.notificator

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.util.Log
import com.example.notificator.models.AlarmItem

class AndroidAlarmScheduler(
    private val context: Context
) : AlarmScheduler {

    private val alarmManager = context.getSystemService(AlarmManager::class.java)

    override fun schedule(item: AlarmItem) {
        Log.d("NotificationChannel", "RYZ: Scheduling: time: ${item.time}")
        val intent = Intent(context, AlarmReceiver::class.java).apply {
            putExtra("message", item.message)
            putExtra("title", item.title)
            putExtra("id", item.id)
            putExtra("time", item.time?.toInstant()?.toEpochMilli())

        }

        item.time?.toInstant()?.let {
            alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                it.toEpochMilli(),
                PendingIntent.getBroadcast(
                    context,
                    1234,
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
            )
        }
    }

    override fun cancel(item: AlarmItem) {
        alarmManager.cancel(
            PendingIntent.getBroadcast(
                context,
                item.hashCode(),
                Intent(context, AlarmReceiver::class.java),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
        )
    }

}