import 'dart:async';

import 'package:flutter/services.dart';
import '../google_api_availability_platform_interface.dart';
import '../models/google_play_services_availability.dart';

/// An implementation of [GoogleApiAvailabilityPlatform] that uses method channels.
class MethodChannelGoogleApiAvailability extends GoogleApiAvailabilityPlatform {
  /// The method channel used to interact with the native platform.
  static const _methodChannel =
      MethodChannel('flutter.baseflow.com/google_api_availability');

  @override
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability([
    bool showDialogIfNecessary = false,
  ]) async {
    final parameters = <String, bool>{
      'showDialogIfNecessary': showDialogIfNecessary,
    };

    final availability = await _methodChannel.invokeMethod(
      'checkGooglePlayServicesAvailability',
      parameters,
    );

    if (availability == null) {
      return GooglePlayServicesAvailability.unknown;
    }

    return GooglePlayServicesAvailability.values[availability];
  }

  @override
  Future<void> makeGooglePlayServicesAvailable() async {
    await _methodChannel.invokeMethod('makeGooglePlayServicesAvailable');
  }

  @override
  Future<String> getErrorString() async {
    final errorString = await _methodChannel.invokeMethod('getErrorString');

    if (errorString == null) {
      return 'ErrorString is null';
    }

    return errorString;
  }

  @override
  Future<bool> isUserResolvable() async {
    final isUserResolvable =
        await _methodChannel.invokeMethod('isUserResolvable');

    if (isUserResolvable == null) {
      return false;
    }

    return isUserResolvable;
  }

  @override
  Future<void> showErrorNotification() async {
    await _methodChannel.invokeMethod('showErrorNotification');
  }

  @override
  Future<bool> showErrorDialogFragment() async {
    final showErrorDialogFragment =
        await _methodChannel.invokeMethod('showErrorDialogFragment');

    if (showErrorDialogFragment == null) {
      return false;
    }

    return showErrorDialogFragment;
  }
}
