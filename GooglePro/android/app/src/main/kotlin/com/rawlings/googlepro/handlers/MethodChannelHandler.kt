package com.rawlings.googlepro.handlers
import android.content.Context
import android.os.BatteryManager
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import com.rawlings.googlepro.MainActivity
import com.rawlings.googlepro.utils.ManufacturerAutoStartHelper
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
class MethodChannelHandler(private val activity: MainActivity) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "openAutoStartSettings" -> result.success(ManufacturerAutoStartHelper.openAutoStartSettings(activity))
            "getManufacturer" -> result.success(ManufacturerAutoStartHelper.getManufacturerName())
            "getDeviceModel" -> result.success(ManufacturerAutoStartHelper.getModelName())
            "getBatteryLevel" -> result.success(getBatteryLevel())
            "getNetworkType" -> result.success(getNetworkType())
            "startForegroundService" -> { com.rawlings.googlepro.service.AppForegroundService.start(activity); result.success(true) }
            "stopForegroundService" -> { com.rawlings.googlepro.service.AppForegroundService.stop(activity); result.success(true) }
            else -> result.notImplemented()
        }
    }
    private fun getBatteryLevel(): Int {
        val bm = activity.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
    private fun getNetworkType(): String {
        val cm = activity.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val n = cm.activeNetwork ?: return "none"
        val cap = cm.getNetworkCapabilities(n) ?: return "none"
        return when {
            cap.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> "wifi"
            cap.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> "mobile"
            cap.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> "ethernet"
            else -> "none"
        }
    }
}