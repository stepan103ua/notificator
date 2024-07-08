package com.example.notificator.models

import java.util.Date

data class AlarmItem(
    val id: Long,
    val time: Date?,
    val message: String,
    val title: String,
)
