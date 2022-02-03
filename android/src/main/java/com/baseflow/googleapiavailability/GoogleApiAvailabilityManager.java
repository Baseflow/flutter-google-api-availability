package com.baseflow.googleapiavailability;

import android.app.Activity;
import android.app.Dialog;
import android.app.PendingIntent;
import android.content.Context;
import android.util.Log;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;

import java.util.List;

public class GoogleApiAvailabilityManager {

    GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();

    @FunctionalInterface
    interface SuccessCallback {
        void onSuccess(int connectionResult);
    }

    @FunctionalInterface
    interface MakeGooglePlayServicesAvailableCallback {
        void onSuccess(boolean makeGooglePlayServicesAvailable);
    }

    @FunctionalInterface
    interface getErrorStringCallback {
        void onSuccess(String errorString);
    }

    @FunctionalInterface
    interface isUserResolvableCallback {
        void onSuccess(boolean isUserResolvable);
    }

    @FunctionalInterface
    interface showErrorNotificationCallback {
        void onSuccess(boolean showErrorNotificationCallback);
    }

    @FunctionalInterface
    interface ErrorCallback {
        void onError(String errorCode, String errorDescription);
    }

    void checkPlayServicesAvailability(Boolean showDialog, Activity activity, Context applicationContext, SuccessCallback successCallback, ErrorCallback errorCallback) {
        if (applicationContext == null || activity == null) {
            Log.d(GoogleApiAvailabilityConstants.LOG_TAG, "Context and/or activity cannot be null.");
            errorCallback.onError("GoogleApiAvailability.GoogleApiAvailabilityManager", "Android context and/or activity cannot be null.");
            return;
        }

        final int connectionResult = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        if (showDialog != null && showDialog) {
            googleApiAvailability
                    .showErrorDialogFragment(activity, connectionResult, GoogleApiAvailabilityConstants.REQUEST_GOOGLE_PLAY_SERVICES);
        }

        successCallback.onSuccess(GoogleApiAvailabilityConstants.toPlayServiceAvailability(connectionResult));
    }

    void makeGooglePlayServicesAvailable(Activity activity, MakeGooglePlayServicesAvailableCallback successCallback, ErrorCallback errorCallback){
        if (activity == null){
            Log.d(GoogleApiAvailabilityConstants.LOG_TAG, "Activity cannot be null.");
            errorCallback.onError("GoogleApiAvailability.makeGooglePlayServicesAvailable", "Android Activity cannot be null.");
            return;
        }

        final boolean status = googleApiAvailability.makeGooglePlayServicesAvailable(activity).isSuccessful();
        successCallback.onSuccess(status);
    }

    void getErrorString(Context applicationContext, getErrorStringCallback successCallback, ErrorCallback errorCallback){
        if (applicationContext == null){
            Log.d(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.getErrorString", "Android context cannot be null.");
            return;
        }

        final String errorString = googleApiAvailability.getErrorString(googleApiAvailability.isGooglePlayServicesAvailable(applicationContext));

        successCallback.onSuccess(errorString);
    }

    void isUserResolvable(Context applicationContext, isUserResolvableCallback successCallback, ErrorCallback errorCallback){
        if (applicationContext == null){
            Log.d(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.isUserResolvable", "Android context cannot be null.");
            return;
        }

        final int connectionResult = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        successCallback.onSuccess(googleApiAvailability.isUserResolvableError(connectionResult));
    }

    void showErrorNotification(Context applicationContext, showErrorNotificationCallback successCallback, ErrorCallback errorCallback){
        if (applicationContext == null){
            Log.d(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.showErrorNotification", "Android context cannot be null.");
            return;
        }

        final int connectionResult = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        googleApiAvailability.showErrorNotification(applicationContext, connectionResult);

        if (connectionResult == GoogleApiAvailabilityConstants.GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_DISABLED ||
            connectionResult == GoogleApiAvailabilityConstants.GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_INVALID ||
            connectionResult == GoogleApiAvailabilityConstants.GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_MISSING ||
            connectionResult == GoogleApiAvailabilityConstants.GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_UPDATING ||
            connectionResult == GoogleApiAvailabilityConstants.GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_VERSION_UPDATE_REQUIRED){
            successCallback.onSuccess(true);
        }

        successCallback.onSuccess(false);
    }
}
