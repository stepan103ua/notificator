package com.example.notificator

import android.app.NotificationManager
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        CustomMethodHandler(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onCreate(
        savedInstanceState: android.os.Bundle?,
        persistentState: android.os.PersistableBundle?
    ) {
        createNotificationChannel()
        super.onCreate(savedInstanceState, persistentState)
    }

    private fun createNotificationChannel() {
        print("RYZ: Notification channel created 0");
        val name = "Scheduled Notifications"
        val descriptionText = "Notifications scheduled by the user"
        val importance = android.app.NotificationManager.IMPORTANCE_DEFAULT
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
            getSystemService(NotificationManager::class.java)

        notificationManager.createNotificationChannel(channel)

        print("RYZ: Notification channel created");
    }
}
