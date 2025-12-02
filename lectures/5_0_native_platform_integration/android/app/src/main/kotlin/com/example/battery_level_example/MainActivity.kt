package com.example.battery_level_example

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    // Must match the channel name used in Dart
    private val CHANNEL = "com.example.battery/methods"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()

                    if (batteryLevel >= 0) {
                        result.success(batteryLevel)
                    } else {
                        // -1 or error condition
                        result.error(
                            "UNAVAILABLE",
                            "Battery level not available.",
                            null
                        )
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getBatteryLevel(): Int {
        // Prefer BatteryManager on Lollipop+ if possible
        val batteryManager =
            getSystemService(Context.BATTERY_SERVICE) as BatteryManager

        // BATTERY_PROPERTY_CAPACITY is typically 0–100 on many devices
        val bmLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            Int.MIN_VALUE
        }

        if (bmLevel in 0..100) {
            return bmLevel
        }

        // Fallback for devices where BATTERY_PROPERTY_CAPACITY is not reliable:
        val intent = ContextWrapper(applicationContext)
            .registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))

        val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1

        if (level == -1 || scale == -1) {
            return -1
        }

        return ((level.toFloat() / scale.toFloat()) * 100).toInt()
    }
}
