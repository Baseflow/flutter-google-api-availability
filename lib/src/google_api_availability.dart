import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_api_availability/src/models/google_play_services_availability.dart';

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
  ///
  /// Returns the connection status of Google Play Service.
  /// Optionally, you can also show an error dialog if the connection status is not [SUCCESS].
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability(
      [bool showDialogIfNecessary = false]) async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw UnsupportedError('Not available on non Android devices.');
    }

    final availability = await _methodChannel.invokeMethod(
        'checkPlayServicesAvailability',
        <String, bool>{'showDialog': showDialogIfNecessary});

    if (availability == null) {
      return GooglePlayServicesAvailability.unknown;
    }

    return GooglePlayServicesAvailability.values[availability];
  }

  /// Attempts to make Google Play services available on this device.
  /// Shows a dialog if the error is resolvable by user.
  ///
  /// If the `Future` completes without throwing an exception, Play Services
  /// is available on this device.
  Future<void> makeGooglePlayServicesAvailable() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw UnsupportedError('Not available on non Android devices.');
    }

    await _methodChannel.invokeMethod('makeGooglePlayServicesAvailable');
  }

  /// Returns a human-readable string of the error code.
  /// Will return "Not available on non Android devices" if used on iOS.
  Future<String> getErrorString() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw UnsupportedError('Not available on non Android devices.');
    }

    final errorString = await _methodChannel.invokeMethod('getErrorString');

    if (errorString == null) {
      return "ErrorString is null";
    }

    return errorString;
  }

  /// Determines whether an error can be resolved via user action.
  Future<bool> isUserResolvable() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw UnsupportedError('Not available on non Android devices.');
    }

    final isUserResolvable =
        await _methodChannel.invokeMethod('isUserResolvable');

    if (isUserResolvable == null) {
      return false;
    }

    return isUserResolvable;
  }

  /// Displays a notification for an error code, if it is resolvable by the user.
  /// This method is similar to [showErrorDialogFragment], but is provided for
  /// background tasks that cannot or should not display dialogs.
  Future<void> showErrorNotification() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw UnsupportedError('Not available on non Android devices.');
    }

    await _methodChannel.invokeMethod('showErrorNotification');
  }

  /// Display an error dialog according to the [ErrorCode] if the connection status is not [SUCCESS].
  ///
  /// Returns true if the connection status did not equal [SUCCESS] or
  /// any other non-[ConnectionResult] value.
  /// Returns false otherwise.
  Future<bool> showErrorDialogFragment() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      throw UnsupportedError('Not available on non Android devices.');
    }

    final showErrorDialogFragment =
        await _methodChannel.invokeMethod('showErrorDialogFragment');

    if (showErrorDialogFragment == null) {
      return false;
    }

    return showErrorDialogFragment;
  }
}
