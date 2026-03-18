package com.rawlings.googlepro.services

import android.app.*
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.rawlings.googlepro.MainActivity

class AppForegroundService : Service() {
    companion object {
        private const val TAG = "GooglePro:FgService"
        private const val NOTIFICATION_ID = 1001
        private const val CHANNEL_ID = "googlepro_fg_service"
        const val ACTION_START = "ACTION_START"
        const val ACTION_STOP = "ACTION_STOP"
        const val EXTRA_SOURCE = "EXTRA_SOURCE"
        var isRunning = false
            private set
    }

    override fun onCreate() {
        super.onCreate()
        isRunning = true
        Log.i(TAG, "Service created")
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, buildNotification("GooglePro Active", "Monitoring devices"))
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val source = intent?.getStringExtra(EXTRA_SOURCE) ?: "unknown"
        Log.i(TAG, "onStartCommand source=$source")
        if (intent?.action == ACTION_STOP) { stopSelf(); return START_NOT_STICKY }
        startForeground(NOTIFICATION_ID, buildNotification("GooglePro Active", "Monitoring devices"))
        return START_STICKY
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        super.onTaskRemoved(rootIntent)
        Log.i(TAG, "Task removed – scheduling restart")
        scheduleRestart(2000L, 1)
    }

    override fun onDestroy() {
        super.onDestroy()
        isRunning = false
        Log.i(TAG, "Service destroyed – scheduling restart")
        scheduleRestart(3000L, 2)
    }

    private fun scheduleRestart(delayMs: Long, requestCode: Int) {
        val intent = Intent(applicationContext, AppForegroundService::class.java).apply {
            action = ACTION_START
            putExtra(EXTRA_SOURCE, "restart_scheduler")
        }
        val pending = PendingIntent.getService(
            applicationContext, requestCode, intent,
            PendingIntent.FLAG_ONE_SHOT or PendingIntent.FLAG_IMMUTABLE
        )
        (getSystemService(ALARM_SERVICE) as AlarmManager).set(
            AlarmManager.RTC_WAKEUP, System.currentTimeMillis() + delayMs, pending
        )
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val ch = NotificationChannel(CHANNEL_ID, "GooglePro Service", NotificationManager.IMPORTANCE_LOW).apply {
                description = "Keeps GooglePro running for auto-connect"
                setShowBadge(false); enableLights(false); enableVibration(false)
            }
            (getSystemService(NotificationManager::class.java)).createNotificationChannel(ch)
        }
    }

    fun buildNotification(title: String, text: String): Notification {
        val pi = PendingIntent.getActivity(this, 0,
            Intent(this, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP },
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(title).setContentText(text)
            .setSmallIcon(android.R.drawable.ic_menu_share)
            .setContentIntent(pi).setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setCategory(NotificationCompat.CATEGORY_SERVICE).setSilent(true).build()
    }
}
