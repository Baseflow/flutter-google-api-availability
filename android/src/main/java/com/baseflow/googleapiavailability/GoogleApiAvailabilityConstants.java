package com.baseflow.googleapiavailability;

import androidx.annotation.IntDef;

import com.google.android.gms.common.ConnectionResult;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

final class GoogleApiAvailabilityConstants {
    static final String LOG_TAG = "google_api_availability";

    static final int REQUEST_GOOGLE_PLAY_SERVICES = 1000;

    //GOOGLE_PLAY_SERVICES_AVAILABILITY
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SUCCESS = 0;
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_MISSING = 1;
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_UPDATING = 2;
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_VERSION_UPDATE_REQUIRED = 3;
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_DISABLED = 4;
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_SERVICE_INVALID = 5;
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_NOT_AVAILABLE_ON_PLATFORM = 6;
    static final int GOOGLE_PLAY_SERVICES_AVAILABILITY_UNKNOWN = 7;


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
    @interface GooglePlayServicesAvailability {
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
