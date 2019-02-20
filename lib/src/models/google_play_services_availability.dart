class GooglePlayServicesAvailability {
  const GooglePlayServicesAvailability._(this.value);

  final int value;

  /// Google Play services are installed on the device and ready to be used.
  static const GooglePlayServicesAvailability success =
      GooglePlayServicesAvailability._(0);

  /// Google Play services is missing on this device.
  static const GooglePlayServicesAvailability serviceMissing =
      GooglePlayServicesAvailability._(1);

  /// Google Play service is currently being updated on this device.
  static const GooglePlayServicesAvailability serviceUpdating =
      GooglePlayServicesAvailability._(2);

  /// The installed version of Google Play services is out of date.
  static const GooglePlayServicesAvailability serviceVersionUpdateRequired =
      GooglePlayServicesAvailability._(3);

  /// The installed version of Google Play services has been disabled on this device.
  static const GooglePlayServicesAvailability serviceDisabled =
      GooglePlayServicesAvailability._(4);

  /// The version of the Google Play services installed on this device is not authentic.
  static const GooglePlayServicesAvailability serviceInvalid =
      GooglePlayServicesAvailability._(5);

  /// Google Play services are not available on this platform.
  static const GooglePlayServicesAvailability notAvailableOnPlatform =
      GooglePlayServicesAvailability._(6);

  /// Unable to determine if Google Play services are installed.
  static const GooglePlayServicesAvailability unknown =
      GooglePlayServicesAvailability._(7);

  static const List<GooglePlayServicesAvailability> values =
      <GooglePlayServicesAvailability>[
    success,
    serviceMissing,
    serviceUpdating,
    serviceVersionUpdateRequired,
    serviceDisabled,
    serviceInvalid,
    notAvailableOnPlatform,
    unknown,
  ];

  static const List<String> _names = <String>[
    'success',
    'serviceMissing',
    'serviceUpdating',
    'serviceVersionUpdateRequired',
    'serviceDisabled',
    'serviceInvalid',
    'notAvailableOnPlatform',
    'unknown',
  ];

  @override
  String toString() => 'GooglePlayServicesAvailability.${_names[value]}';
}
