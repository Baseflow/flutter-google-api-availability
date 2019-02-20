import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_api_availability/src/models/google_play_services_availability.dart';

class GoogleApiAvailability {
  const GoogleApiAvailability._();

  static const GoogleApiAvailability instance = GoogleApiAvailability._();
  static MethodChannel methodChannel = const MethodChannel(
      'flutter.baseflow.com/google_api_availability/methods');

  /// This feature is only available on Android devices. On any other platforms
  /// the [checkPlayServicesAvailability] method will always return
  /// [GooglePlayServicesAvailability.notAvailableOnPlatform].
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability(
      [bool showDialogIfNecessary = false]) async {
    if (!Platform.isAndroid) {
      return GooglePlayServicesAvailability.notAvailableOnPlatform;
    }

    final int availability = await methodChannel.invokeMethod(
        'checkPlayServicesAvailability',
        <String, bool>{'showDialog': showDialogIfNecessary});

    return GooglePlayServicesAvailability.values[availability];
  }
}
