import 'package:flutter_test/flutter_test.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:google_api_availability_platform_interface/google_api_availability_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockGoogleApiAvailabilityPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements GoogleApiAvailabilityPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GoogleApiAvailability', () {
    late GoogleApiAvailabilityPlatform googleApiAvailabilityPlatform;
    late GoogleApiAvailability googleApiAvailability;

    setUp(() {
      // Arrange.
      googleApiAvailabilityPlatform = MockGoogleApiAvailabilityPlatform();
      GoogleApiAvailabilityPlatform.instance = googleApiAvailabilityPlatform;
      googleApiAvailability = const GoogleApiAvailability.private();
    });

    group('checkGooglePlayServicesAvailability', () {
      test('Should throw if no platform implementation is registered',
          () async {
        // Arrange.
        GoogleApiAvailabilityPlatform.removeInstance();

        // Act & Assert.
        expect(
          googleApiAvailability.checkGooglePlayServicesAvailability,
          throwsA(isA<UnsupportedError>()),
        );
      });

      test('Should receive the corresponding $GooglePlayServicesAvailability',
          () async {
        // Arrange.
        const availability = GooglePlayServicesAvailability.serviceDisabled;

        when(() => googleApiAvailabilityPlatform
                .checkGooglePlayServicesAvailability())
            .thenAnswer((_) async => availability);

        // Act.
        final googlePlayServiceAvailability =
            await googleApiAvailability.checkGooglePlayServicesAvailability();

        // Assert.
        expect(
          googlePlayServiceAvailability,
          availability,
        );
      });
    });

    group('makeGooglePlayServicesAvailable', () {
      test('Should throw if no platform implementation is registered',
          () async {
        // Arrange.
        GoogleApiAvailabilityPlatform.removeInstance();

        // Act & Assert.
        expect(
          googleApiAvailability.makeGooglePlayServicesAvailable,
          throwsA(isA<UnsupportedError>()),
        );
      });
    });

    group('getErrorString', () {
      test('Should throw if no platform implementation is registered',
          () async {
        // Arrange.
        GoogleApiAvailabilityPlatform.removeInstance();

        // Act & Assert.
        expect(
          googleApiAvailability.getErrorString,
          throwsA(isA<UnsupportedError>()),
        );
      });

      test('Should receive the corresponding error string', () async {
        // Arrange.
        const expectedErrorString = 'test_error_string';

        when(() => googleApiAvailabilityPlatform.getErrorString())
            .thenAnswer((_) async => expectedErrorString);

        // Act.
        final errorString =
            await const GoogleApiAvailability.private().getErrorString();

        // Assert.
        expect(
          errorString,
          expectedErrorString,
        );
      });
    });

    group('isUserResolvable', () {
      test('Should throw if no platform implementation is registered',
          () async {
        // Arrange.
        GoogleApiAvailabilityPlatform.removeInstance();

        // Act & Assert.
        expect(
          googleApiAvailability.isUserResolvable,
          throwsA(isA<UnsupportedError>()),
        );
      });

      test('Should receive true if the user is resolvable', () async {
        // Arrange.
        const expectedIsUserResolvable = true;

        when(() => googleApiAvailabilityPlatform.isUserResolvable())
            .thenAnswer((_) async => expectedIsUserResolvable);

        // Act.
        final isUserResolvable = await googleApiAvailability.isUserResolvable();

        // Assert.
        expect(
          isUserResolvable,
          expectedIsUserResolvable,
        );
      });

      test('Should receive false if the user is not resolvable', () async {
        // Arrange.
        const expectedIsUserResolvable = false;

        when(() => googleApiAvailabilityPlatform.isUserResolvable())
            .thenAnswer((_) async => expectedIsUserResolvable);

        // Act.
        final isUserResolvable = await googleApiAvailability.isUserResolvable();

        // Assert.
        expect(
          isUserResolvable,
          expectedIsUserResolvable,
        );
      });
    });

    group('showErrorNotification', () {
      test('Should throw if no platform implementation is registered',
          () async {
        // Arrange.
        GoogleApiAvailabilityPlatform.removeInstance();

        // Act & Assert.
        expect(
          googleApiAvailability.showErrorNotification,
          throwsA(isA<UnsupportedError>()),
        );
      });
    });

    group('showErrorDialogFragment', () {
      test('Should throw if no platform implementation is registered',
          () async {
        // Arrange.
        GoogleApiAvailabilityPlatform.removeInstance();

        // Act & Assert.
        expect(
          googleApiAvailability.showErrorDialogFragment,
          throwsA(isA<UnsupportedError>()),
        );
      });

      test('Should receive false when dialog should not be shown', () async {
        // Arrange.
        const expectedShowDialogFragment = false;

        when(() => googleApiAvailabilityPlatform.showErrorDialogFragment())
            .thenAnswer((_) async => expectedShowDialogFragment);

        // Act.
        final showErrorDialogFragment =
            await googleApiAvailability.showErrorDialogFragment();

        // Assert.
        expect(
          expectedShowDialogFragment,
          showErrorDialogFragment,
        );
      });

      test('Should receive true when dialog should be shown', () async {
        // Arrange.
        const expectedShowDialogFragment = true;

        when(() => googleApiAvailabilityPlatform.showErrorDialogFragment())
            .thenAnswer((_) async => expectedShowDialogFragment);

        // Act.
        final showErrorDialogFragment =
            await googleApiAvailability.showErrorDialogFragment();

        // Assert.
        expect(
          expectedShowDialogFragment,
          showErrorDialogFragment,
        );
      });
    });
  });
}
