package com.rawlings.googlepro

import android.app.AlertDialog
import android.content.Intent
import android.os.Build
import android.os.Bundle
import com.rawlings.googlepro.service.AppForegroundService
import com.rawlings.googlepro.utils.BatteryOptimizationHelper
import com.rawlings.googlepro.utils.ManufacturerAutoStartHelper
import com.rawlings.googlepro.worker.AutoConnectWorker
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.rawlings.googlepro/native"
    private var methodChannel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startForegroundServiceIfNeeded()
        scheduleAutoConnectWorker()
        requestBatteryOptimizationIfNeeded()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "openAutoStartSettings" -> {
                    val opened = ManufacturerAutoStartHelper.openAutoStartSettings(this)
                    result.success(opened)
                }
                "getManufacturer" -> result.success(ManufacturerAutoStartHelper.getManufacturerName())
                "getDeviceName" -> result.success(ManufacturerAutoStartHelper.getModelName())
                "needsAutoStart" -> result.success(ManufacturerAutoStartHelper.needsAutoStartPermission())
                "getBatteryLevel" -> result.success(getBatteryLevel())
                "requestBatteryOptimization" -> {
                    BatteryOptimizationHelper.requestIgnoreBatteryOptimizations(this)
                    result.success(true)
                }
                "isIgnoringBatteryOptimizations" -> {
                    result.success(BatteryOptimizationHelper.isIgnoringBatteryOptimizations(this))
                }
                "startForegroundService" -> {
                    AppForegroundService.start(this)
                    result.success(true)
                }
                "stopForegroundService" -> {
                    AppForegroundService.stop(this)
                    result.success(true)
                }
                "updateServiceNotification" -> {
                    val title = call.argument<String>("title") ?: "GooglePro"
                    val text = call.argument<String>("text") ?: "Running"
                    AppForegroundService.update(this, title, text)
                    result.success(true)
                }
                "getAndroidVersion" -> result.success(Build.VERSION.SDK_INT)
                "scheduleAutoConnect" -> {
                    AutoConnectWorker.schedule(this)
                    result.success(true)
                }
                "cancelAutoConnect" -> {
                    AutoConnectWorker.cancel(this)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startForegroundServiceIfNeeded() {
        try {
            AppForegroundService.start(this)
        } catch (e: Exception) {
            android.util.Log.w("GooglePro", "FG service start failed: ${e.message}")
        }
    }

    private fun scheduleAutoConnectWorker() {
        try {
            AutoConnectWorker.schedule(this)
        } catch (e: Exception) {
            android.util.Log.w("GooglePro", "WorkManager schedule failed: ${e.message}")
        }
    }

    private fun requestBatteryOptimizationIfNeeded() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
            !BatteryOptimizationHelper.isIgnoringBatteryOptimizations(this)) {
            // Show dialog to user after a short delay
            window.decorView.postDelayed({
                if (!isFinishing) showBatteryOptimizationDialog()
            }, 3000)
        }
    }

    private fun showBatteryOptimizationDialog() {
        AlertDialog.Builder(this)
            .setTitle("Battery Optimization")
            .setMessage("Disable battery optimization for GooglePro to ensure reliable auto-connect after reboot.")
            .setPositiveButton("Disable") { _, _ -> BatteryOptimizationHelper.requestIgnoreBatteryOptimizations(this) }
            .setNegativeButton("Not Now", null)
            .setCancelable(true)
            .show()
    }

    private fun getBatteryLevel(): Int {
        return try {
            val intent = registerReceiver(null, android.content.IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            val level = intent?.getIntExtra(android.os.BatteryManager.EXTRA_LEVEL, -1) ?: -1
            val scale = intent?.getIntExtra(android.os.BatteryManager.EXTRA_SCALE, -1) ?: -1
            if (level != -1 && scale != -1) (level * 100 / scale) else -1
        } catch (e: Exception) { -1 }
    }

    override fun onDestroy() {
        methodChannel?.setMethodCallHandler(null)
        super.onDestroy()
    }
}
