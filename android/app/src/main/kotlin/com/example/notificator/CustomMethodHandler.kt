package com.example.notificator

import android.content.Context
import com.example.notificator.models.AlarmItem
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.Date

class CustomMethodHandler(
    context: Context,
    messenger: BinaryMessenger
) : MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(messenger, "com.example.notificator")
    private val scheduler = AndroidAlarmScheduler(context)

    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "schedule" -> {
                print("RYZ: Scheduling")
                val time = call.argument<Long>("time") ?: return
                val message = call.argument<String>("message") ?: return
                val title = call.argument<String>("title") ?: return
                val id = call.argument<Long>("id") ?: return
                val date = Date(time)

                val item = AlarmItem(id, date, message, title)

                scheduler.schedule(item)

                result.success(null)
            }

            "cancel" -> {
                val time = call.argument<Long>("time") ?: return
                val message = call.argument<String>("message") ?: return
                val title = call.argument<String>("title") ?: return
                val id = call.argument<Long>("id") ?: return
                val date = Date(time)

                val item = AlarmItem(id, date, message, title)

                scheduler.cancel(item)

                result.success(null)
            }

            else -> result.notImplemented()
        }
    }
}