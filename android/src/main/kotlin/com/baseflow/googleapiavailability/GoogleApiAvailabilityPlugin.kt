package com.baseflow.googleapiavailability

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.baseflow.googleapiavailability.data.PlayServicesAvailability
import com.baseflow.googleapiavailability.utils.Codec
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability

class GoogleApiAvailabilityPlugin(val activity: Activity) : MethodCallHandler {
    companion object {
        val REQUEST_GOOGLE_PLAY_SERVICES = 1000

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter.baseflow.com/google_api_availability/methods")
            channel.setMethodCallHandler(GoogleApiAvailabilityPlugin(activity = registrar.activity()))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when {
            call.method == "checkPlayServicesAvailability" -> {
                val showDialog: Boolean? = call.argument("showDialog")
                val googleApiAvailability = GoogleApiAvailability.getInstance()
                val connectionResult = googleApiAvailability.isGooglePlayServicesAvailable(activity)

                if (showDialog != null && showDialog){
                    googleApiAvailability.showErrorDialogFragment(activity, connectionResult, REQUEST_GOOGLE_PLAY_SERVICES)
                }

                val availability = toPlayServiceAvailability(connectionResult)
                result.success(Codec.encodePlayServicesAvailability(availability))
            }
            else -> result.notImplemented()
        }
    }

    private fun toPlayServiceAvailability(connectionResult: Int): PlayServicesAvailability {
        var availability: PlayServicesAvailability = PlayServicesAvailability.UNKNOWN

        when (connectionResult) {
            ConnectionResult.SUCCESS ->
                availability = PlayServicesAvailability.SUCCESS
            ConnectionResult.SERVICE_MISSING ->
                availability = PlayServicesAvailability.SERVICE_MISSING
            ConnectionResult.SERVICE_UPDATING ->
                availability = PlayServicesAvailability.SERVICE_UPDATING
            ConnectionResult.SERVICE_VERSION_UPDATE_REQUIRED ->
                availability = PlayServicesAvailability.SERVICE_VERSION_UPDATE_REQUIRED
            ConnectionResult.SERVICE_DISABLED ->
                availability = PlayServicesAvailability.SERVICE_DISABLED
            ConnectionResult.SERVICE_INVALID ->
                availability = PlayServicesAvailability.SERVICE_INVALID
        }

        return availability;
    }
}
