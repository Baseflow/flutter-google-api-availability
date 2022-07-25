package com.baseflow.googleapiavailability;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.IntDef;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

public class MethodCallHandlerImpl implements MethodChannel.MethodCallHandler {

    private final GoogleApiAvailabilityManager googleApiAvailabilityManager;

    MethodCallHandlerImpl(Context applicationContext, GoogleApiAvailabilityManager googleApiAvailabilityManager) {
        this.applicationContext = applicationContext;

        this.googleApiAvailabilityManager = googleApiAvailabilityManager;
    }

    private final Context applicationContext;

    @Nullable
    private Activity activity;

    void setActivity(@Nullable Activity activity) {
        this.activity = activity;
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "checkPlayServicesAvailability": {
                final Boolean showDialog = call.argument("showDialog");
                googleApiAvailabilityManager.checkPlayServicesAvailability(showDialog, activity, applicationContext, result::success,
                        (String errorCode, String errorDescription) -> result.error(
                        errorCode,
                        errorDescription,
                        null));
                break;
            }
            case "makeGooglePlayServicesAvailable": {
                googleApiAvailabilityManager.makeGooglePlayServicesAvailable(activity,result::success,
                        (String errorCode, String errorDescription) -> result.error(
                                errorCode,
                                errorDescription,
                                null));
                break;
            }
            case "getErrorString": {
                googleApiAvailabilityManager.getErrorString(applicationContext, result::success,(String errorCode, String errorDescription) -> result.error(
                        errorCode,
                        errorDescription,
                        null));
                break;
            }
            case "isUserResolvable": {
                googleApiAvailabilityManager.isUserResolvable(applicationContext, result::success,(String errorCode, String errorDescription) -> result.error(
                        errorCode,
                        errorDescription,
                        null));
                break;
            }
            case "showErrorNotification": {
                googleApiAvailabilityManager.showErrorNotification(applicationContext, result::success,(String errorCode, String errorDescription) -> result.error(
                        errorCode,
                        errorDescription,
                        null));
                break;
            }
            case "showErrorDialogFragment": {
                googleApiAvailabilityManager.showErrorDialogFragment(applicationContext, activity, result::success,(String errorCode, String errorDescription) -> result.error(
                        errorCode,
                        errorDescription,
                        null));
                break;
            }
            default:
                result.notImplemented();
                break;
        }
    }
}
