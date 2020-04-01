package com.baseflow.googleapiavailability;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.IntDef;
import androidx.annotation.Nullable;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * GoogleApiAvailabilityPlugin
 */
public class GoogleApiAvailabilityPlugin implements MethodCallHandler, FlutterPlugin, ActivityAware {
    private static final int REQUEST_GOOGLE_PLAY_SERVICES = 1000;

    //GOOGLE_PLAY_SERVICES_AVAILABILITY
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SUCCESS = 0;
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_MISSING = 1;
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_UPDATING = 2;
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_VERSION_UPDATE_REQUIRED = 3;
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_DISABLED = 4;
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_INVALID = 5;
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_NOT_AVAILABLE_ON_PLATFORM = 6;
    private static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_UNKNOWN = 7;

    @Retention(RetentionPolicy.SOURCE)
    @IntDef({
            GOOGLE_PLAY_SERVICES_AVAILABILITY_SUCCESS,
            GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_MISSING,
            GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_UPDATING,
            GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_VERSION_UPDATE_REQUIRED,
            GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_DISABLED,
            GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_INVALID,
            GOOGLE_PLAY_SERVICES_AVAILABILITY_NOT_AVAILABLE_ON_PLATFORM,
            GOOGLE_PLAY_SERVICES_AVAILABILITY_UNKNOWN,
    })
    private @interface GooglePlayServicesAvailability {
    }

    private Context applicationContext;
    private @Nullable Activity activity;
    private MethodChannel methodChannel;


    public static void registerWith(Registrar registrar) {
        final GoogleApiAvailabilityPlugin plugin = new GoogleApiAvailabilityPlugin();
        plugin.registerPlugin(
                registrar.context(),
                registrar.activity(),
                registrar.messenger());
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        registerPlugin(
                binding.getApplicationContext(),
                null,
                binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        applicationContext = null;
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

    private void registerPlugin(Context applicationContext, Activity activity, BinaryMessenger messenger) {
        this.applicationContext = applicationContext;
        this.activity = activity;
        methodChannel = new MethodChannel(messenger, "flutter.baseflow.com/google_api_availability/methods");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("checkPlayServicesAvailability")) {
            final Boolean showDialog = call.argument("showDialog");
            GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();
            final int connectionResult = googleApiAvailability.isGooglePlayServicesAvailable(applicationContext);

            if (activity != null && showDialog != null && showDialog) {
                googleApiAvailability.showErrorDialogFragment(activity, connectionResult, REQUEST_GOOGLE_PLAY_SERVICES);
            }

            final int availability = toPlayServiceAvailability(connectionResult);
            result.success(availability);
        } else {
            result.notImplemented();
        }
    }

    @GooglePlayServicesAvailability
    private int toPlayServiceAvailability(int connectionResult) {
        switch (connectionResult) {
            case ConnectionResult.SUCCESS:
                return GOOGLE_PLAY_SERVICES_AVAILABILITY_SUCCESS;
            case ConnectionResult.SERVICE_MISSING:
                return GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_MISSING;
            case ConnectionResult.SERVICE_UPDATING:
                return GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_UPDATING;
            case ConnectionResult.SERVICE_VERSION_UPDATE_REQUIRED:
                return GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_VERSION_UPDATE_REQUIRED;
            case ConnectionResult.SERVICE_DISABLED:
                return GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_DISABLED;
            case ConnectionResult.SERVICE_INVALID:
                return GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_INVALID;
            default:
                return GOOGLE_PLAY_SERVICES_AVAILABILITY_UNKNOWN;
        }
    }
}