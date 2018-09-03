package com.baseflow.googleapiavailability

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.baseflow.googleapiavailability.data.PlayServicesAvailability
import com.baseflow.googleapiavailability.utils.Codec

class GoogleApiAvailabilityPlugin(val context: Context): MethodCallHandler {
  companion object {
    val REQUEST_GOOGLE_PLAY_SERVICES = 1000

    @JvmStatic
    fun registerWith(registrar: Registrar): Unit {
      val channel = MethodChannel(registrar.messenger(), "flutter.baseflow.com/google_api_availability/methods")
      channel.setMethodCallHandler(GoogleApiAvailabilityPlugin(context = registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result): Unit {
    when {
          call.method == "checkPlayServicesAvailability" -> {
            val googleApiAvailability = GoogleApiAvailability.getInstance()
            val connectionResult = googleApiAvailability.isGooglePlayServicesAvailable(context)
            val availability = toPlayServiceAvailability(connectionResult)

            //TODO: Add optional bool to show error dialog
            //if (GoogleApiAvailability.getInstance().showErrorDialogFragment(context, connectionResult, REQUEST_GOOGLE_PLAY_SERVICES)) {
            //     return
            //}
            result.success(Codec.encodePlayServicesAvailability(availability));
          }
          else -> result.notImplemented()
      }
  }

  private fun toPlayServiceAvailability(connectionResult: int): PlayServicesAvailability {
        val availability: PlayServicesAvailability

        when (permission) {
        PlayServicesAvailability.SUCCESS -> {
            availability = PlayServicesAvailability.SUCCESS
        }
        when (permission) {
        PlayServicesAvailability.SERVICE_MISSING -> {
            availability = PlayServicesAvailability.SERVICE_MISSING
        }
        when (permission) {
        PlayServicesAvailability.SERVICE_UPDATING -> {
            availability = PlayServicesAvailability.SERVICE_UPDATING
        }
        when (permission) {
        PlayServicesAvailability.SERVICE_VERSION_UPDATE_REQUIRED -> {
            availability = PlayServicesAvailability.SERVICE_VERSION_UPDATE_REQUIRED
        }
        when (permission) {
        PlayServicesAvailability.SERVICE_DISABLED -> {
            availability = PlayServicesAvailability.SERVICE_DISABLED
        }
        when (permission) {
        PlayServicesAvailability.SERVICE_INVALID -> {
            availability = PlayServicesAvailability.SERVICE_INVALID
        }
        else -> availability = PlayServicesAvailability.UNKNOWN
        }

        return availability;
    }
}
