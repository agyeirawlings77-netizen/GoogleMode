package com.rawlings.googlepro.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import com.rawlings.googlepro.services.AppForegroundService

class BootReceiver : BroadcastReceiver() {
    companion object { private const val TAG = "GooglePro:Boot" }

    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action ?: return
        Log.i(TAG, "Boot action: $action")
        when (action) {
            Intent.ACTION_BOOT_COMPLETED,
            "android.intent.action.QUICKBOOT_POWERON",
            "com.htc.intent.action.QUICKBOOT_POWERON",
            Intent.ACTION_MY_PACKAGE_REPLACED -> startService(context)
        }
    }

    private fun startService(context: Context) {
        try {
            val intent = Intent(context, AppForegroundService::class.java).apply {
                action = AppForegroundService.ACTION_START
                putExtra(AppForegroundService.EXTRA_SOURCE, "boot_receiver")
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
            Log.i(TAG, "Foreground service started after boot")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start service", e)
        }
    }
}
