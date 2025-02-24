import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_api_availability_android/google_api_availability_android.dart';
import 'package:google_api_availability_platform_interface/google_api_availability_platform_interface.dart';

void main() => runApp(const MyApp());

///Creates the mutable state for this widget.
class MyApp extends StatefulWidget {
  /// Named [key] parameter to identify a widget.
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GooglePlayServicesAvailability _playStoreAvailability =
      GooglePlayServicesAvailability.unknown;
  String _errorString = 'unknown';
  bool _isUserResolvable = false;
  bool _errorDialogFragmentShown = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkPlayServices([bool showDialog = false]) async {
    GooglePlayServicesAvailability playStoreAvailability;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      playStoreAvailability = await GoogleApiAvailabilityAndroid()
          .checkGooglePlayServicesAvailability(showDialog);
    } on PlatformException {
      playStoreAvailability = GooglePlayServicesAvailability.unknown;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _playStoreAvailability = playStoreAvailability;
    });
  }

  Future<void> makeGooglePlayServicesAvailable() async {
    try {
      await GoogleApiAvailabilityAndroid().makeGooglePlayServicesAvailable();
    } on PlatformException {
      return;
    }

    if (!mounted) {
      return;
    }
  }

  Future<void> getErrorString() async {
    String errorString;

    try {
      errorString = await GoogleApiAvailabilityAndroid().getErrorString();
    } on PlatformException {
      errorString = 'Not available on non Android devices';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _errorString = errorString;
    });
  }

  Future<void> isUserResolvable() async {
    bool isUserResolvable;

    try {
      isUserResolvable =
          await GoogleApiAvailabilityAndroid().isUserResolvable();
    } on PlatformException {
      isUserResolvable = false;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isUserResolvable = isUserResolvable;
    });
  }

  Future<void> showErrorNotification() async {
    try {
      await GoogleApiAvailabilityAndroid().showErrorNotification();
    } on PlatformException {
      return;
    }

    if (!mounted) {
      return;
    }
  }

  Future<void> showErrorDialogFragment() async {
    bool errorDialogFragmentShown;

    try {
      errorDialogFragmentShown =
          await GoogleApiAvailabilityAndroid().showErrorDialogFragment();
    } on PlatformException {
      errorDialogFragmentShown = false;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _errorDialogFragmentShown = errorDialogFragmentShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: ListView(
          children: <Widget>[
            MaterialButton(
              onPressed: () => checkPlayServices(),
              color: Colors.red,
              child: const Text('Get PlayServices availability'),
            ),
            Center(
              child: Text(
                'Google Play Store status: ${_playStoreAvailability.toString().split('.').last}\n',
              ),
            ),
            MaterialButton(
              onPressed: () => checkPlayServices(true),
              color: Colors.redAccent,
              child: const Text(
                'Get PlayServices availability with fix dialog',
              ),
            ),
            Center(
              child: Text(
                'Google Play Store status: ${_playStoreAvailability.toString().split('.').last}\n',
              ),
            ),
            MaterialButton(
              onPressed: () => makeGooglePlayServicesAvailable(),
              color: Colors.red,
              child: const Text('Make Google Play Service available'),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              onPressed: () => getErrorString(),
              color: Colors.red,
              child: const Text('Get string of the error code'),
            ),
            Center(child: Text('Error string: $_errorString\n')),
            MaterialButton(
              onPressed: () => isUserResolvable(),
              color: Colors.red,
              child: const Text('Error resolvable by user'),
            ),
            Center(
              child: Text('Error resolvable by user: $_isUserResolvable\n'),
            ),
            MaterialButton(
              onPressed: () => showErrorNotification(),
              color: Colors.red,
              child: const Text('Show error notification'),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              onPressed: () => showErrorDialogFragment(),
              color: Colors.red,
              child: const Text('Show error dialog fragment'),
            ),
            Center(
              child: Text('Error dialog shown: $_errorDialogFragmentShown\n'),
            ),
          ],
        ),
      ),
    );
  }
}
