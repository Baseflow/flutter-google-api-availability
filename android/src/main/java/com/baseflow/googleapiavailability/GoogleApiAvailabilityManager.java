package com.baseflow.googleapiavailability;

import android.app.Activity;
import android.app.Dialog;
import android.app.PendingIntent;
import android.content.Context;
import android.util.Log;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.tasks.Task;

import java.util.List;

public class GoogleApiAvailabilityManager {

    GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();

    @FunctionalInterface
    interface SuccessCallback {
        void onSuccess(int connectionResult);
    }

    @FunctionalInterface
    interface MakeGooglePlayServicesAvailableCallback {
        void onSuccess(Void v);
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
        void onSuccess(Void v);
    }

    @FunctionalInterface
    interface showErrorDialogFragmentCallback {
        void onSuccess(boolean showErrorDialogFragmentCallback);
    }

    @FunctionalInterface
    interface ErrorCallback {
        void onError(String errorCode, String errorDescription);
    }

    void checkPlayServicesAvailability(Boolean showDialog, Activity activity, Context applicationContext, SuccessCallback successCallback, ErrorCallback errorCallback) {
        if (applicationContext == null) {
            Log.e(GoogleApiAvailabilityConstants.LOG_TAG, "The `ApplicationContext` cannot be null.");
            errorCallback.onError("GoogleApiAvailability.GoogleApiAvailabilityManager", "Android `ApplicationContext` cannot be null.");
            return;
        }

        final int connectionResult = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        if (activity == null) {
            if (showDialog != null && showDialog) {
                // Only log warning when `showDialog` property was `true`.
                Log.w(GoogleApiAvailabilityConstants.LOG_TAG, "Unable to show dialog as `Activity` is not available.");
            }
            showDialog = false;
        }

        if (showDialog != null && showDialog) {
            googleApiAvailability
                    .showErrorDialogFragment(activity, connectionResult, GoogleApiAvailabilityConstants.REQUEST_GOOGLE_PLAY_SERVICES);
        }

        successCallback.onSuccess(GoogleApiAvailabilityConstants.toPlayServiceAvailability(connectionResult));
    }

    void makeGooglePlayServicesAvailable(Activity activity, MakeGooglePlayServicesAvailableCallback successCallback, ErrorCallback errorCallback) {
        if (activity == null) {
            Log.e(GoogleApiAvailabilityConstants.LOG_TAG, "Activity cannot be null.");
            errorCallback.onError("GoogleApiAvailability.makeGooglePlayServicesAvailable", "Android Activity cannot be null.");
            return;
        }

        googleApiAvailability.makeGooglePlayServicesAvailable(activity)
                .addOnFailureListener((Exception e) -> errorCallback.onError("GoogleApiAvailability.makeGooglePlayServicesAvailable", e.getMessage()))
                .addOnSuccessListener((Void t) -> successCallback.onSuccess(null));
    }

    void getErrorString(Context applicationContext, getErrorStringCallback successCallback, ErrorCallback errorCallback) {
        if (applicationContext == null) {
            Log.e(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.getErrorString", "Android context cannot be null.");
            return;
        }

        final String errorString = googleApiAvailability.getErrorString(googleApiAvailability.isGooglePlayServicesAvailable(applicationContext));

        successCallback.onSuccess(errorString);
    }

    void isUserResolvable(Context applicationContext, isUserResolvableCallback successCallback, ErrorCallback errorCallback) {
        if (applicationContext == null) {
            Log.e(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.isUserResolvable", "Android context cannot be null.");
            return;
        }

        final int connectionResult = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        successCallback.onSuccess(googleApiAvailability.isUserResolvableError(connectionResult));
    }

    void showErrorNotification(Context applicationContext, showErrorNotificationCallback successCallback, ErrorCallback errorCallback) {
        if (applicationContext == null) {
            Log.e(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.showErrorNotification", "Android context cannot be null.");
            return;
        }

        final int connectionResult = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        googleApiAvailability.showErrorNotification(applicationContext, connectionResult);

        successCallback.onSuccess(null);
    }

    void showErrorDialogFragment(Context applicationContext, Activity activity, showErrorDialogFragmentCallback successCallback, ErrorCallback errorCallback) {
        if (applicationContext == null) {
            Log.e(GoogleApiAvailabilityConstants.LOG_TAG, "Context cannot be null.");
            errorCallback.onError("GoogleApiAvailability.showErrorDialogFragment", "Android context cannot be null.");
            return;
        }

        final int errorCode = googleApiAvailability
                .isGooglePlayServicesAvailable(applicationContext);

        if (errorCode != GoogleApiAvailabilityConstants.GOOGLE_PLAY_SERVICES_AVAILABILITY_SUCCESS) {
            googleApiAvailability.showErrorDialogFragment(activity, errorCode, GoogleApiAvailabilityConstants.REQUEST_GOOGLE_PLAY_SERVICES);
            successCallback.onSuccess(true);
        }

        successCallback.onSuccess(false);
    }
}
