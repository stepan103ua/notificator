package com.example.notificator

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat
import com.example.notificator.models.AlarmItem


class NotificationChannelService(private val context: Context) {

    fun showNotification(alarmItem: AlarmItem) {
        val intent: Intent = Intent(context, MainActivity::class.java).apply {
            putExtra("alarm_item_id", alarmItem.id)
        }

        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)

        val pendingIntent =
            PendingIntent.getActivity(
                context, 0, intent,
                PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE,
            )

        NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Scheduled Notification")
            .setContentText(alarmItem.message)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .build()
    }

    companion object {
        const val CHANNEL_ID = "notificator_channel_01";
    }
}