import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:google_api_availability/src/models/google_play_services_availability.dart';

import 'models/google_play_services_availability.dart';

/// Flutter plugin to verify if Google Play Services are installed on the
/// device.
class GoogleApiAvailability {
  const GoogleApiAvailability._();

  @visibleForTesting
  const GoogleApiAvailability.private();

  /// Acquires an instance of the [GoogleApiAvailability] class.
  static const GoogleApiAvailability instance = GoogleApiAvailability._();

  static final MethodChannel _methodChannel = const MethodChannel(
      'flutter.baseflow.com/google_api_availability/methods');

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
}
