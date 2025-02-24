import 'package:flutter_test/flutter_test.dart';
import 'package:google_api_availability_android/src/google_api_availability_android.dart';
import 'package:google_api_availability_platform_interface/google_api_availability_platform_interface.dart';

import 'method_channel_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('checkGooglePlayServiceAvailability', () {
    test(
      'Should receive the corresponding GooglePlayServiceAvailability',
      () async {
        // Arrange
        const availability = GooglePlayServicesAvailability.serviceDisabled;

        MethodChannelMock(
          channelName:
              'flutter.baseflow.com/google_api_availability_android/methods',
          method: 'checkPlayServicesAvailability',
          result: availability.value,
        );

        // Act
        final googlePlayServiceAvailability =
            await GoogleApiAvailabilityAndroid()
                .checkGooglePlayServicesAvailability();

        // Assert
        expect(googlePlayServiceAvailability, availability);
      },
    );

    test(
      'Should receive GooglePlayServiceAvailability.unknown when availability is null',
      () async {
        // Arrange
        const availability = null;

        MethodChannelMock(
          channelName:
              'flutter.baseflow.com/google_api_availability_android/methods',
          method: 'checkPlayServicesAvailability',
          result: availability,
        );

        // Act
        final googlePlayServiceAvailability =
            await GoogleApiAvailabilityAndroid()
                .checkGooglePlayServicesAvailability();

        // Assert
        expect(
          googlePlayServiceAvailability,
          GooglePlayServicesAvailability.unknown,
        );
      },
    );
  });

  group('getErrorString', () {
    test(
      'Should receive "ErrorString is null" when availability is null',
      () async {
        // Arrange
        const errorString = null;

        MethodChannelMock(
          channelName:
              'flutter.baseflow.com/google_api_availability_android/methods',
          method: 'getErrorString',
          result: errorString,
        );

        // Act
        final errorStringResult =
            await GoogleApiAvailabilityAndroid().getErrorString();

        //Assert
        expect(errorStringResult, "ErrorString is null");
      },
    );

    test(
      'Should receive ${GooglePlayServicesAvailability.success} when connection status is success',
      () async {
        // Arrange
        MethodChannelMock(
          channelName:
              'flutter.baseflow.com/google_api_availability_android/methods',
          method: 'getErrorString',
          result: "SUCCESS",
        );

        // Act
        final errorString =
            await GoogleApiAvailabilityAndroid().getErrorString();

        // Assert
        expect(errorString, "SUCCESS");
      },
    );
  });

  group('isUserResolvable', () {
    test('Should receive false when isUserResolvable is null', () async {
      // Arrange
      const isUserResolvable = null;

      MethodChannelMock(
        channelName:
            'flutter.baseflow.com/google_api_availability_android/methods',
        method: 'isUserResolvable',
        result: isUserResolvable,
      );

      // Act
      final isUserResolvableResult =
          await GoogleApiAvailabilityAndroid().isUserResolvable();

      // Assert
      expect(isUserResolvableResult, false);
    });

    test('Should receive true when error is user resolvable', () async {
      // Arrange
      MethodChannelMock(
        channelName:
            'flutter.baseflow.com/google_api_availability_android/methods',
        method: 'isUserResolvable',
        result: true,
      );

      // Act
      final isUserResolvable =
          await GoogleApiAvailabilityAndroid().isUserResolvable();

      // Assert
      expect(isUserResolvable, true);
    });
  });

  group('showErrorDialogFragment', () {
    test('Should receive false when showErrorDialogFragment is null', () async {
      // Arrange
      const showErrorDialogFragment = null;

      MethodChannelMock(
        channelName:
            'flutter.baseflow.com/google_api_availability_android/methods',
        method: 'showErrorDialogFragment',
        result: showErrorDialogFragment,
      );

      // Act
      final showErrorDialogFragmentResult =
          await GoogleApiAvailabilityAndroid().showErrorDialogFragment();

      // Assert
      expect(showErrorDialogFragmentResult, false);
    });

    test('Should receive true when error dialog fragment is shown', () async {
      // Arrange
      MethodChannelMock(
        channelName:
            'flutter.baseflow.com/google_api_availability_android/methods',
        method: 'showErrorDialogFragment',
        result: true,
      );

      // Act
      final showErrorDialogFragment =
          await GoogleApiAvailabilityAndroid().showErrorDialogFragment();

      // Assert
      expect(showErrorDialogFragment, true);
    });
  });
}
