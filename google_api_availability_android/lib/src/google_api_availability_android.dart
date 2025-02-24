import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_api_availability_platform_interface/google_api_availability_platform_interface.dart';

/// An Android implementation of [GoogleApiAvailabilityPlatform] that used method channels.
class GoogleApiAvailabilityAndroid extends GoogleApiAvailabilityPlatform {
  static const MethodChannel _methodChannel = MethodChannel(
    'flutter.baseflow.com/google_api_availability_android/methods',
  );

  /// Registers this class as the default instance of [GoogleApiAvailabilityPlatform].
  static void registerWith() {
    GoogleApiAvailabilityPlatform.instance = GoogleApiAvailabilityAndroid();
  }

  /// Returns the connection status of Google Play Service.
  ///
  /// Optionally, you can also show an error dialog if the connection status is
  /// not [GooglePlayServicesAvailability.success].
  @override
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability([
    bool showDialogIfNecessary = false,
  ]) async {
    final availability = await _methodChannel.invokeMethod(
      'checkPlayServicesAvailability',
      <String, bool>{'showDialog': showDialogIfNecessary},
    );

    if (availability == null) {
      return GooglePlayServicesAvailability.unknown;
    }

    return GooglePlayServicesAvailability.values[availability];
  }

  /// Attempts to make Google Play services available on this device.
  ///
  /// Shows a dialog if the error is resolvable by user.
  ///
  /// If the [Future] completes without throwing an exception, Play Services
  /// is available on this device.
  @override
  Future<void> makeGooglePlayServicesAvailable() async {
    await _methodChannel.invokeMethod('makeGooglePlayServicesAvailable');
  }

  /// Returns a human-readable string of the error code.
  @override
  Future<String> getErrorString() async {
    final errorString = await _methodChannel.invokeMethod('getErrorString');

    if (errorString == null) {
      return "ErrorString is null";
    }

    return errorString;
  }

  /// Determines whether an error can be resolved via user action.
  @override
  Future<bool> isUserResolvable() async {
    final isUserResolvable = await _methodChannel.invokeMethod(
      'isUserResolvable',
    );

    if (isUserResolvable == null) {
      return false;
    }

    return isUserResolvable;
  }

  /// Displays a notification for an error code, if it is resolvable by the user.
  ///
  /// This method is similar to [showErrorDialogFragment], but is provided for
  /// background tasks that cannot or should not display dialogs.
  @override
  Future<void> showErrorNotification() async {
    await _methodChannel.invokeMethod('showErrorNotification');
  }

  /// Displays an error dialog according to the error code if the connection
  /// status is not [GooglePlayServicesAvailability.success].
  ///
  /// Returns true if the connection status did not equal
  /// [GooglePlayServicesAvailability.success] or any other
  /// non-[ConnectionResult] value. Returns false otherwise.
  @override
  Future<bool> showErrorDialogFragment() async {
    final showErrorDialogFragment = await _methodChannel.invokeMethod(
      'showErrorDialogFragment',
    );

    if (showErrorDialogFragment == null) {
      return false;
    }

    return showErrorDialogFragment;
  }
}
