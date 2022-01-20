import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_api_availability/google_api_availability.dart';

import 'method_channel_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Should receive notAvailableOnPlatform is not Android', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    final googlePlayServiceAvailability =
        await const GoogleApiAvailability.private()
            .checkGooglePlayServicesAvailability();

    expect(googlePlayServiceAvailability,
        GooglePlayServicesAvailability.notAvailableOnPlatform);

    debugDefaultTargetPlatformOverride = null;
  });

  test('Should receive the corresponding GooglePlayServiceAvailability',
      () async {
    const availability = GooglePlayServicesAvailability.serviceDisabled;

    MethodChannelMock(
      channelName: 'flutter.baseflow.com/google_api_availability/methods',
      method: 'checkPlayServicesAvailability',
      result: availability.value,
    );

    final googlePlayServiceAvailability =
        await const GoogleApiAvailability.private()
            .checkGooglePlayServicesAvailability();

    expect(googlePlayServiceAvailability, availability);
  });

  test(
      'Should receive GooglePlayServiceAvailability.unknown when availability is null',
      () async {
    const availability = null;

    MethodChannelMock(
      channelName: 'flutter.baseflow.com/google_api_availability/methods',
      method: 'checkPlayServicesAvailability',
      result: availability,
    );

    final googlePlayServiceAvailability =
        await const GoogleApiAvailability.private()
            .checkGooglePlayServicesAvailability();

    expect(
        googlePlayServiceAvailability, GooglePlayServicesAvailability.unknown);
  });
}
