import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_api_availability/google_api_availability.dart';

import 'method_channel_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('checkGooglePlayServiceAvailability', () {
    test('Should receive notAvailableOnPlatform if not Android', () async {
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

      expect(googlePlayServiceAvailability,
          GooglePlayServicesAvailability.unknown);
    });
  });

  group('makeGooglePlayServicesAvailable', () {
    test('Should receive false if not Android', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final googlePlayServiceAvailability =
          await const GoogleApiAvailability.private()
              .makeGooglePlayServicesAvailable();

      expect(googlePlayServiceAvailability, false);

      debugDefaultTargetPlatformOverride = null;
    });

    test('Should receive false when availability is null', () async {
      const availability = null;

      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'makeGooglePlayServicesAvailable',
        result: availability,
      );

      final googlePlayServiceAvailability =
          await const GoogleApiAvailability.private()
              .makeGooglePlayServicesAvailable();

      expect(googlePlayServiceAvailability, false);
    });

    test(
        'Should receive true when device is able to set Google Play Services to available',
        () async {
      const availability = true;

      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'makeGooglePlayServicesAvailable',
        result: availability,
      );

      final makeGooglePlayServiceAvailability =
          await const GoogleApiAvailability.private()
              .makeGooglePlayServicesAvailable();

      expect(makeGooglePlayServiceAvailability, true);
    });
  });

  group('getErrorString', () {
    test(
        'Should receive "Not available on non Android devices" if not on Android',
        () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final errorString =
          await const GoogleApiAvailability.private().getErrorString();

      expect(errorString, "Not available on non Android devices");

      debugDefaultTargetPlatformOverride = null;
    });

    test('Should receive "ErrorString is null" when availability is null',
        () async {
      const errorString = null;

      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'getErrorString',
        result: errorString,
      );

      final errorStringResult =
          await const GoogleApiAvailability.private().getErrorString();

      expect(errorStringResult, "ErrorString is null");
    });

    test('Should receive SUCCESS when connection status is success', () async {
      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'getErrorString',
        result: "SUCCESS",
      );

      final errorString =
          await const GoogleApiAvailability.private().getErrorString();

      expect(errorString, "SUCCESS");
    });
  });

  group('isUserResolvable', () {
    test('Should receive false if not Android', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final isUserResolvable =
          await const GoogleApiAvailability.private().isUserResolvable();

      expect(isUserResolvable, false);

      debugDefaultTargetPlatformOverride = null;
    });

    test('Should receive false when isUserResolvable is null', () async {
      const isUserResolvable = null;

      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'isUserResolvable',
        result: isUserResolvable,
      );

      final isUserResolvableResult =
          await const GoogleApiAvailability.private().isUserResolvable();

      expect(isUserResolvableResult, false);
    });

    test('Should receive true when error is user resolvable', () async {
      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'isUserResolvable',
        result: true,
      );

      final isUserResolvable =
          await const GoogleApiAvailability.private().isUserResolvable();

      expect(isUserResolvable, true);
    });
  });

  group('showErrorNotification', () {
    test('Should receive false if not Android', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final showErrorNotification =
          await const GoogleApiAvailability.private().showErrorNotification();

      expect(showErrorNotification, false);

      debugDefaultTargetPlatformOverride = null;
    });

    test('Should receive false when showErrorNotification is null', () async {
      const showErrorNotification = null;

      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'showErrorNotification',
        result: showErrorNotification,
      );

      final showErrorNotificationResult =
          await const GoogleApiAvailability.private().showErrorNotification();

      expect(showErrorNotificationResult, false);
    });

    test('Should receive true when notification is shown', () async {
      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'showErrorNotification',
        result: true,
      );

      final showErrorNotification =
          await const GoogleApiAvailability.private().showErrorNotification();

      expect(showErrorNotification, true);
    });
  });

  group('showErrorDialogFragment', () {
    test('Should receive false if not Android', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      final showErrorDialogFragment =
          await const GoogleApiAvailability.private().showErrorDialogFragment();

      expect(showErrorDialogFragment, false);

      debugDefaultTargetPlatformOverride = null;
    });

    test('Should receive false when showErrorDialogFragment is null', () async {
      const showErrorDialogFragment = null;

      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'showErrorDialogFragment',
        result: showErrorDialogFragment,
      );

      final showErrorDialogFragmentResult =
          await const GoogleApiAvailability.private().showErrorDialogFragment();

      expect(showErrorDialogFragmentResult, false);
    });

    test('Should receive true when error dialog fragment is shown', () async {
      MethodChannelMock(
        channelName: 'flutter.baseflow.com/google_api_availability/methods',
        method: 'showErrorDialogFragment',
        result: true,
      );

      final showErrorDialogFragment =
          await const GoogleApiAvailability.private().showErrorDialogFragment();

      expect(showErrorDialogFragment, true);
    });
  });
}
