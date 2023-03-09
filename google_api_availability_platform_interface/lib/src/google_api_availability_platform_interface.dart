import 'package:google_api_availability_platform_interface/google_api_availability_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of `google_api_availability` must implement.
///
/// Platform implementations should extend this class rather than implement it
/// as `google_api_availability` does not consider newly added methods to be
/// breaking changes. Extending this class (using `extends`) ensures that the
/// subclass will get the default implementation, while platform implementations
/// that `implements` this interface will be broken by newly added
/// [GoogleApiAvailabilityPlatform] methods.
abstract class GoogleApiAvailabilityPlatform extends PlatformInterface {
  /// Constructs a [GoogleApiAvailabilityPlatform].
  GoogleApiAvailabilityPlatform() : super(token: _token);

  static final Object _token = Object();

  static GoogleApiAvailabilityPlatform? _instance;

  /// The default instance of [GoogleApiAvailabilityPlatform] to use.
  static GoogleApiAvailabilityPlatform? get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [GoogleApiAvailabilityPlatform] when they register
  /// themselves.
  static set instance(GoogleApiAvailabilityPlatform? instance) {
    if (instance == null) {
      throw AssertionError(
          'Platform interfaces can only be set to a non-null instance');
    }

    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Returns the connection status of Google Play Service.
  ///
  /// Optionally, you can also show an error dialog if the connection status is
  /// not [GooglePlayServicesAvailability.success].
  Future<GooglePlayServicesAvailability> checkGooglePlayServicesAvailability([
    bool showDialogIfNecessary = false,
  ]) {
    throw UnimplementedError(
      'checkGooglePlayServicesAvailability() has not been implemented.',
    );
  }

  /// Attempts to make Google Play Services available on this device.
  ///
  /// Shows a dialog if the error is resolvable by user.
  /// If the `Future` completes without throwing an exception, Play Services
  /// is available on this device.
  Future<void> makeGooglePlayServicesAvailable() {
    throw UnimplementedError(
      'makeGooglePlayServicesAvailable() has not been implemented.',
    );
  }

  /// Returns a human-readable string of the error code.
  Future<String> getErrorString() {
    throw UnimplementedError(
      'getErrorString() has not been implemented.',
    );
  }

  /// Determines whether an error can be resolved via user action.
  Future<bool> isUserResolvable() {
    throw UnimplementedError(
      'isUserResolvable() has not been implemented.',
    );
  }

  /// Displays a notification for an error code, if it is resolvable by the user.
  ///
  /// This method is similar to [showErrorDialogFragment], but is provided for
  /// background tasks that cannot or should not display dialogs.
  Future<void> showErrorNotification() {
    throw UnimplementedError(
      'showErrorNotification() has not been implemented.',
    );
  }

  /// Display an error dialog according to the [ErrorCode] if the connection
  /// status is not [GooglePlayServicesAvailability.success].
  ///
  /// Returns true if the connection status did not equal
  /// [GooglePlayServicesAvailability.success] or any other
  /// non-[ConnectionResult] value.
  /// Returns false otherwise.
  Future<bool> showErrorDialogFragment() {
    throw UnimplementedError(
      'showErrorDialogFragment() has not been implemented.',
    );
  }
}
