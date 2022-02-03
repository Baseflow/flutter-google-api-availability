import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_api_availability/src/models/google_play_services_availability.dart';

import 'models/google_play_services_availability.dart';

/// Flutter plugin to verify if Google Play Services are installed on the
/// device.
class GoogleApiAvailability {
  const GoogleApiAvailability._();

  /// Creates an instance of the [GoogleApiAvailability] class. This
  /// constructor is exposed for testing purposes only and should not be used
  /// by clients of the plugin as it may break or change at any time.
  @visibleForTesting
  const GoogleApiAvailability.private();

  /// Acquires an instance of the [GoogleApiAvailability] class.
  static const GoogleApiAvailability instance = GoogleApiAvailability._();

  static const MethodChannel _methodChannel =
      MethodChannel('flutter.baseflow.com/google_api_availability/methods');

  /// This feature is only available on Android devices. On any other platforms
  /// the [checkPlayServicesAvailability] method will always return
  /// [GooglePlayServicesAvailability.notAvailableOnPlatform].
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability(
      [bool showDialogIfNecessary = false]) async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return GooglePlayServicesAvailability.notAvailableOnPlatform;
    }

    final availability = await _methodChannel.invokeMethod(
        'checkPlayServicesAvailability',
        <String, bool>{'showDialog': showDialogIfNecessary});

    if (availability == null) {
      return GooglePlayServicesAvailability.unknown;
    }

    return GooglePlayServicesAvailability.values[availability];
  }

  /// Returns true if the device was able to set Google Play Services to available,
  /// Returns false if the device was unable to set Google Play Services to available or status is unknown.
  ///
  /// If it is necessary to display UI in order to complete this request
  /// (e.g. sending the user to the Google Play store) the passed Activity will be used to display this UI.
  Future<bool> makeGooglePlayServicesAvailable() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }

    final availability =
        await _methodChannel.invokeMethod('makeGooglePlayServicesAvailable');

    return availability;
  }

  /// Returns the result of the connection status as a string.
  /// Will return "Not available on non Android devices" if used on iOS.
  Future<String> getErrorString() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return "Not available on non Android devices";
    }

    final errorString = await _methodChannel.invokeMethod('getErrorString');

    return errorString;
  }

  /// Returns true if the error is resolvable with getErrorDialog.
  /// Returns false if the error is not resolvable by the user,
  /// or the Play Service Availability is already available.
  Future<bool> isUserResolvable() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }

    final isUserResolvable =
        await _methodChannel.invokeMethod('isUserResolvable');

    return isUserResolvable;
  }

  /// Displays a notification for an error code, if it is resolvable by the user.
  /// This method is similar to [getErrorDialog], but is provided for
  /// background tasks that cannot or should not display dialogs.
  ///
  /// Returns true if the connection status did not equal [SUCCESS] or
  /// any other non-[ConnectionResult] value.
  /// Returns false otherwise.
  Future<bool> showErrorNotification() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }

    final showErrorNotification =
        await _methodChannel.invokeMethod('showErrorNotification');

    return showErrorNotification;
  }
}
