package com.rawlings.googlepro.utils

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Build

object ManufacturerAutoStartHelper {

    private val AUTOSTART_INTENTS = mapOf(
        "xiaomi" to Intent().setComponent(ComponentName("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity")),
        "redmi" to Intent().setComponent(ComponentName("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity")),
        "oppo" to Intent().setComponent(ComponentName("com.coloros.safecenter", "com.coloros.safecenter.startupapp.StartupAppListActivity")),
        "vivo" to Intent().setComponent(ComponentName("com.vivo.permissionmanager", "com.vivo.permissionmanager.activity.BgStartUpManagerActivity")),
        "huawei" to Intent().setComponent(ComponentName("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity")),
        "honor" to Intent().setComponent(ComponentName("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity")),
        "samsung" to Intent().setComponent(ComponentName("com.samsung.android.lool", "com.samsung.android.sm.ui.battery.BatteryActivity")),
        "oneplus" to Intent().setComponent(ComponentName("com.oneplus.security", "com.oneplus.security.chainlaunch.view.ChainLaunchAppListActivity")),
        "realme" to Intent().setComponent(ComponentName("com.coloros.safecenter", "com.coloros.safecenter.startupapp.StartupAppListActivity")),
        "tecno" to Intent().setComponent(ComponentName("com.transsion.phonemaster", "com.transsion.phonemaster.ui.autostart.AutostartFragment")),
        "itel" to Intent().setComponent(ComponentName("com.transsion.phonemaster", "com.transsion.phonemaster.ui.autostart.AutostartFragment")),
        "infinix" to Intent().setComponent(ComponentName("com.transsion.phonemaster", "com.transsion.phonemaster.ui.autostart.AutostartFragment")),
        "lenovo" to Intent().setComponent(ComponentName("com.lenovo.security", "com.lenovo.security.purebackground.PureBackgroundActivity")),
        "asus" to Intent().setComponent(ComponentName("com.asus.mobilemanager", "com.asus.mobilemanager.autostart.AutostartActivity")),
    )

    fun openAutoStartSettings(context: Context): Boolean {
        val manufacturer = Build.MANUFACTURER.lowercase()
        val matchedIntent = AUTOSTART_INTENTS.entries.firstOrNull { manufacturer.contains(it.key) }?.value
        return if (matchedIntent != null) {
            try {
                context.startActivity(matchedIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
                true
            } catch (e: Exception) {
                false
            }
        } else {
            false
        }
    }

    fun getManufacturerName(): String = Build.MANUFACTURER
    fun getModelName(): String = "${Build.MANUFACTURER} ${Build.MODEL}"
    fun needsAutoStartPermission(): Boolean = AUTOSTART_INTENTS.keys.any { Build.MANUFACTURER.lowercase().contains(it) }
}
