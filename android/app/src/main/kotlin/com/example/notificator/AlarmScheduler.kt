package com.example.notificator

import com.example.notificator.models.AlarmItem

interface AlarmScheduler {
    fun schedule(item: AlarmItem)

    fun cancel(item: AlarmItem)
}