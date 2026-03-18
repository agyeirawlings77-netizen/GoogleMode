package com.rawlings.googlepro.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import com.rawlings.googlepro.service.AppForegroundService
import com.rawlings.googlepro.worker.AutoConnectWorker

class BootReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action ?: return

        if (action == Intent.ACTION_BOOT_COMPLETED ||
            action == Intent.ACTION_LOCKED_BOOT_COMPLETED ||
            action == "android.intent.action.QUICKBOOT_POWERON" ||
            action == "com.htc.intent.action.QUICKBOOT_POWERON") {

            // Start the foreground service on boot
            AppForegroundService.start(context)

            // Schedule the periodic WorkManager task
            AutoConnectWorker.schedule(context)
        }
    }
}
