import 'dart:async';

import 'package:flutter/services.dart';

class GoogleApiAvailability {
  static const MethodChannel _channel =
      const MethodChannel('google_api_availability');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
