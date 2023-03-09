# Flutter Google API Availability plugin

The Flutter Google API Availability plugin is built following the federated plugin architecture. A detailed explanation of the federated plugin concept can be found in the [Flutter documentation](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins). This means the Google API Availability plugin is separated into the following packages:

1. [`google_api_availability`][1]: the app facing package. This is the package users depend on to use the plugin in their project. For details on how to use the [`google_api_availability`][1] plugin you can refer to its [README.md][2] file.
2. [`google_api_availability_platform_interface`][3]: this package declares the interface which all platform packages must implement to support the app-facing package. Instructions on how to implement a platform package can be found in the [README.md][4] of the [`google_api_availability_platform_interface`][3] package.

[1]: ./google_api_availability
[2]: ./google_api_availability/README.md
[3]: ./google_api_availability_platform_interface
[4]: ./google_api_availability_platform_interface/README.md
