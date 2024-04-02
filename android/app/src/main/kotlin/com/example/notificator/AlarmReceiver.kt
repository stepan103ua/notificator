package com.example.notificator

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.example.notificator.models.AlarmItem
import java.util.Date

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        Log.d("NotificationChannel", "RYZ: Alarm received")
        val message = intent?.getStringExtra("message") ?: return
        val title = intent.getStringExtra("title") ?: return
        val id = intent.getLongExtra("id", 0)
        val time = intent.getLongExtra("time", 0)
        val parsedDate = Date(time)

        val item = AlarmItem(id, parsedDate, message, title)

        NotificationChannelService(context!!).showNotification(item)
    }
}