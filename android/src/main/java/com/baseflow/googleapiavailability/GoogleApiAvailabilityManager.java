package com.baseflow.googleapiavailability;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.google.android.gms.common.GoogleApiAvailability;

public class GoogleApiAvailabilityManager {

    GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();

    @FunctionalInterface
    interface SuccessCallback {
        void onSuccess(@GoogleApiAvailabilityConstants.GooglePlayServicesAvailability int connectionResult);
    }

    @FunctionalInterface
    interface MakeGooglePlayServicesAvailable {
        void onSuccess(boolean makeGooglePlayServicesAvailable);
    }

    @FunctionalInterface
    interface ErrorCallback {
        void onError(String errorCode, String errorDescription);
    }

    void checkPlayServicesAvailability(Boolean showDialog, Context applicationContext, SuccessCallback successCallback, ErrorCallback errorCallback) {
        if (applicationContext == null) {
            Log.d(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.GoogleApiAvailabilityManager", "Android context cannot be null.");
            return;
        }

        final int connectionResult = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        if (showDialog != null && showDialog) {
            googleApiAvailability
                    .showErrorDialogFragment((Activity) applicationContext, connectionResult, GoogleApiAvailabilityConstants.REQUEST_GOOGLE_PLAY_SERVICES);
        }

        successCallback.onSuccess(connectionResult);
    }

    void makeGooglePlayServicesAvailable(Activity activity, MakeGooglePlayServicesAvailable successCallback, ErrorCallback errorCallback){
        if (activity == null){
            Log.d(GoogleApiAvailabilityConstants.LOG_TAG, "Activity cannot be null.");
            errorCallback.onError("GoogleApiAvailability.makeGooglePlayServicesAvailable", "Android Activity cannot be null.");
            return;
        }

        final boolean status = googleApiAvailability.makeGooglePlayServicesAvailable(activity).isSuccessful();
        successCallback.onSuccess(status);
    }
}
