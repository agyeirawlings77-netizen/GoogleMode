package com.rawlings.googlepro.handlers

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import com.rawlings.googlepro.MainActivity

class NotificationHandler(private val context: Context) {
    companion object {
        private const val CHANNEL_DEFAULT = "googlepro_default"
        private const val CHANNEL_CONNECTION = "googlepro_connection"
        private const val CHANNEL_ALERT = "googlepro_alert"
    }

    init { createChannels() }

    private fun createChannels() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        listOf(
            NotificationChannel(CHANNEL_DEFAULT, "Notifications", NotificationManager.IMPORTANCE_DEFAULT),
            NotificationChannel(CHANNEL_CONNECTION, "Connections", NotificationManager.IMPORTANCE_LOW).apply { setShowBadge(false) },
            NotificationChannel(CHANNEL_ALERT, "Security Alerts", NotificationManager.IMPORTANCE_HIGH)
        ).forEach { manager.createNotificationChannel(it) }
    }

    fun showConnectionNotification(deviceName: String, connected: Boolean) {
        val title = if (connected) "Connected" else "Disconnected"
        val body = if (connected) "Connected to $deviceName" else "$deviceName disconnected"
        show(100, title, body, CHANNEL_CONNECTION)
    }

    fun showAlertNotification(title: String, body: String) = show(300, title, body, CHANNEL_ALERT)

    private fun show(id: Int, title: String, body: String, channelId: String) {
        val intent = PendingIntent.getActivity(context, 0, Intent(context, MainActivity::class.java), PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val notif = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(android.R.drawable.ic_menu_share)
            .setContentTitle(title).setContentText(body)
            .setContentIntent(intent).setAutoCancel(true).build()
        (context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager).notify(id, notif)
    }
}
