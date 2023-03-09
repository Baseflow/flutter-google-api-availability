// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:google_api_availability_platform_interface/google_api_availability_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:mockito/mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$GoogleApiAvailabilityPlatform', () {
    test('The default instance is null', () {
      expect(GoogleApiAvailabilityPlatform.instance, isNull);
    });

    test('Cannot be implemented with `implements`', () {
      expect(() {
        GoogleApiAvailabilityPlatform.instance =
            ImplementsGoogleApiAvailabilityPlatform();
        // In versions of `package:plugin_platform_interface` prior to fixing
        // https://github.com/flutter/flutter/issues/109339, an attempt to
        // implement a platform interface using `implements` would sometimes
        // throw a `NoSuchMethodError` and other times throw an
        // `AssertionError`.  After the issue is fixed, an `AssertionError` will
        // always be thrown.  For the purpose of this test, we don't really care
        // what exception is thrown, so just allow any exception.
      }, throwsA(anything));
    });

    test('Can be extended', () {
      GoogleApiAvailabilityPlatform.instance =
          ExtendsGoogleApiAvailabilityPlatform();
    });

    test('Can be mocked with `implements`', () {
      final mock = MockGoogleApiAvailabilityPlatform();
      GoogleApiAvailabilityPlatform.instance = mock;
    });

    test(
        'Default implementation of checkGooglePlayServicesAvailability should throw unimplemented error',
        () {
      // Arrange
      final googleApiAvailabilityPlatform =
          ExtendsGoogleApiAvailabilityPlatform();

      // Act & Assert
      expect(
        () =>
            googleApiAvailabilityPlatform.checkGooglePlayServicesAvailability(),
        throwsUnimplementedError,
      );
    });

    test(
        'Default implementation of makeGooglePlayServicesAvailable should throw unimplemented error',
        () {
      // Arrange
      final googleApiAvailabilityPlatform =
          ExtendsGoogleApiAvailabilityPlatform();

      // Act & Assert
      expect(
        () => googleApiAvailabilityPlatform.makeGooglePlayServicesAvailable(),
        throwsUnimplementedError,
      );
    });

    test(
        'Default implementation of getErrorString should throw unimplemented error',
        () {
      // Arrange
      final googleApiAvailabilityPlatform =
          ExtendsGoogleApiAvailabilityPlatform();

      // Act & Assert
      expect(
        () => googleApiAvailabilityPlatform.getErrorString(),
        throwsUnimplementedError,
      );
    });

    test(
        'Default implementation of isUserResolvable should throw unimplemented error',
        () {
      // Arrange
      final googleApiAvailabilityPlatform =
          ExtendsGoogleApiAvailabilityPlatform();

      // Act & Assert
      expect(
        () => googleApiAvailabilityPlatform.isUserResolvable(),
        throwsUnimplementedError,
      );
    });

    test(
        'Default implementation of showErrorNotification should throw unimplemented error',
        () {
      // Arrange
      final googleApiAvailabilityPlatform =
          ExtendsGoogleApiAvailabilityPlatform();

      // Act & Assert
      expect(
        () => googleApiAvailabilityPlatform.showErrorNotification(),
        throwsUnimplementedError,
      );
    });

    test(
        'Default implementation of showErrorDialogFragment should throw unimplemented error',
        () {
      // Arrange
      final googleApiAvailabilityPlatform =
          ExtendsGoogleApiAvailabilityPlatform();

      // Act & Assert
      expect(
        () => googleApiAvailabilityPlatform.showErrorDialogFragment(),
        throwsUnimplementedError,
      );
    });
  });
}

class ImplementsGoogleApiAvailabilityPlatform
    implements GoogleApiAvailabilityPlatform {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockGoogleApiAvailabilityPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements GoogleApiAvailabilityPlatform {}

class ExtendsGoogleApiAvailabilityPlatform
    extends GoogleApiAvailabilityPlatform {}
