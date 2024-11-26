package com.example.notificator

import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private lateinit var customMethodHandler: CustomMethodHandler

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        Log.d("NotificationChannel","RYZ: configureFlutterEngine")
        customMethodHandler = CustomMethodHandler(this, flutterEngine.dartExecutor.binaryMessenger)
        super.configureFlutterEngine(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        Log.d("NotificationChannel","RYZ: onCreate")
        super.onCreate(savedInstanceState)
        val intent: Intent = intent

        Log.d("NotificationChannel","RYZ: onCreate intent ${intent.getLongExtra("alarm_item_id", 0L)}")

        intent.getLongExtra("alarm_item_id", 0L).let {
            if (it != 0L) {
                val data = mapOf("alarm_item_id" to it)
                Log.d("NotificationChannel","RYZ: Notification clicked $data")
                customMethodHandler.invokeMethod("onNotificationClick", data)
            }
        }
        createNotificationChannel()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        if (intent.getLongExtra("alarm_item_id", 0L) != 0L) {
            val data = mapOf("alarm_item_id" to intent.getLongExtra("alarm_item_id", 0L))
            Log.d("NotificationChannel","RYZ: Notification clicked $data")
            customMethodHandler.invokeMethod("onNotificationClick", data)
        }
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
