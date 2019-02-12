library google_api_availability;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'models/google_play_services_availability.dart';
part 'utils/codec.dart';

class GoogleApiAvailability {
  factory GoogleApiAvailability() {
    if (_instance == null) {
      const MethodChannel methodChannel =
          MethodChannel('flutter.baseflow.com/google_api_availability/methods');
      _instance = GoogleApiAvailability.private(methodChannel);
    }
    return _instance;
  }

  @visibleForTesting
  GoogleApiAvailability.private(this._methodChannel);

  static GoogleApiAvailability _instance;

  final MethodChannel _methodChannel;

  /// This feature is only available on Android devices. On any other platforms
  /// the [checkPlayServicesAvailability] method will always return
  /// [GooglePlayServicesAvailability.notAvailableOnPlatform].
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability(
      [bool showDialogIfNecessary = false]) async {
    if (!Platform.isAndroid) {
      return GooglePlayServicesAvailability.notAvailableOnPlatform;
    }

    final dynamic availability = await _methodChannel.invokeMethod<String>(
        'checkPlayServicesAvailability',
        <String, bool>{'showDialog': showDialogIfNecessary});

    return Codec.decodePlayServicesAvailability(availability);
  }
}
