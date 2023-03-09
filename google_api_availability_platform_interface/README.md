# google_api_availability_platform_interface

[![style: flutter_lints](https://img.shields.io/badge/style-flutter_lints-40c4ff.svg)](https://pub.dev/packages/flutter_lints)

A common platform interface for the [`google_api_availability`][1] plugin.

This interface allows platform-specific implementations of the `google_api_availability`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface. Have a look at the [Federated plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins) 
section of the official [Developing packages & plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages) 
documentation for more information regarding the federated architecture concept. 

## Usage

To implement a new platform-specific implementation of `google_api_availability`, extend
[`GoogleApiAvailabilityPlatform`][2] with an implementation that performs the
platform-specific behavior, and when you register your plugin, set the default
`GoogleApiAvailabilityPlatform` by calling
`GoogleApiAvailabilityPlatform.instance = MyGoogleApiAvailabilityPlatform()`.

## Note on breaking changes

Strongly prefer non-breaking changes (such as adding a method to the interface)
over breaking changes for this package.

See https://flutter.dev/go/platform-interface-breaking-changes for a discussion
on why a less-clean interface is preferable to a breaking change.

## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/Baseflow/flutter-google-api-availability/issues) page. Commercial support is available, you can contact us at <hello@baseflow.com>.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](../CONTRIBUTING.md) and send us your [pull request](https://github.com/Baseflow/flutter-google-api-availability/pulls).

## Author

This Google API Availability plugin for Flutter is developed by [Baseflow](https://baseflow.com).

[1]: ../google_api_availability
[2]: lib/google_api_availability_platform_interface.dart
