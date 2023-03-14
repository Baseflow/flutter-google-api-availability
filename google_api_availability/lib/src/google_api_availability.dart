import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_api_availability_platform_interface/google_api_availability_platform_interface.dart';

/// Flutter plugin to verify if Google Play Services are installed on the device.
class GoogleApiAvailability {
  const GoogleApiAvailability._();

  /// Creates an instance of the [GoogleApiAvailability] class.
  ///
  /// This constructor is exposed for testing purposes only and should not be
  /// used by clients of the plugin as it may break or change at any time.
  @visibleForTesting
  const GoogleApiAvailability.private();

  /// Acquires an instance of the [GoogleApiAvailability] class.
  static const GoogleApiAvailability instance = GoogleApiAvailability._();

  /// Returns the connection status of Google Play Services.
  ///
  /// Optionally, you can also show an error dialog if the connection status is
  /// not [SUCCESS].
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability(
      [bool showDialogIfNecessary = false]) async {
    if (GoogleApiAvailabilityPlatform.instance == null) {
      throw UnsupportedError('This platform is not supported.');
    }

    final availability = await GoogleApiAvailabilityPlatform.instance!
        .checkGooglePlayServicesAvailability(showDialogIfNecessary);

    return GooglePlayServicesAvailability.values[availability.value];
  }

  /// Attempts to make Google Play Services available on this device.
  ///
  /// Shows a dialog if the error is resolvable by user.
  ///
  /// If the `Future` completes without throwing an exception, Play Services is
  /// available on this device.
  Future<void> makeGooglePlayServicesAvailable() async {
    if (GoogleApiAvailabilityPlatform.instance == null) {
      throw UnsupportedError('This platform is not supported.');
    }
    await GoogleApiAvailabilityPlatform.instance!
        .makeGooglePlayServicesAvailable();
  }

  /// Returns a human-readable string of the error code.
  Future<String> getErrorString() async {
    if (GoogleApiAvailabilityPlatform.instance == null) {
      throw UnsupportedError('This platform is not supported.');
    }

    final errorString =
        await GoogleApiAvailabilityPlatform.instance!.getErrorString();

    return errorString;
  }

  /// Determines whether an error can be resolved via user action.
  Future<bool> isUserResolvable() async {
    if (GoogleApiAvailabilityPlatform.instance == null) {
      throw UnsupportedError('This platform is not supported.');
    }

    final isUserResolvable =
        await GoogleApiAvailabilityPlatform.instance!.isUserResolvable();

    return isUserResolvable;
  }

  /// Displays a notification for an error code, if it is resolvable by the user.
  ///
  /// This method is similar to [showErrorDialogFragment], but is provided for
  /// background tasks that cannot or should not display dialogs.
  Future<void> showErrorNotification() async {
    if (GoogleApiAvailabilityPlatform.instance == null) {
      throw UnsupportedError('This platform is not supported.');
    }

    await GoogleApiAvailabilityPlatform.instance!.showErrorNotification();
  }

  /// Display an error dialog according to the [ErrorCode] if the connection
  /// status is not [SUCCESS].
  ///
  /// Returns true if the connection status did not equal [SUCCESS] or any other
  /// non-[ConnectionResult] value.
  /// Returns false otherwise.
  Future<bool> showErrorDialogFragment() async {
    if (GoogleApiAvailabilityPlatform.instance == null) {
      throw UnsupportedError('This platform is not supported.');
    }

    final showErrorDialogFragment =
        await GoogleApiAvailabilityPlatform.instance!.showErrorDialogFragment();

    return showErrorDialogFragment;
  }
}
