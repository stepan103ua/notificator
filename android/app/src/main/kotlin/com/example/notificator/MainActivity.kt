package com.example.notificator

import android.app.NotificationManager
import android.content.Context
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        Log.d("NotificationChannel","RYZ: configureFlutterEngine")
        super.configureFlutterEngine(flutterEngine)
        CustomMethodHandler(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        Log.d("NotificationChannel","RYZ: onCreate")
        super.onCreate(savedInstanceState)
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        Log.d("NotificationChannel","RYZ: Notification channel created 0");
        val name = "Scheduled Notifications"
        val descriptionText = "Notifications scheduled by the user"
        val importance = NotificationManager.IMPORTANCE_HIGH
        val channel =
            android.app.NotificationChannel(
                NotificationChannelService.CHANNEL_ID,
                name,
                importance,
            )
                .apply {
                    description = descriptionText
                }

        val notificationManager: NotificationManager =
            getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        notificationManager.createNotificationChannel(channel)

        Log.d("NotificationChannel","RYZ: Notification channel created");
    }
}
