import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_api_availability/google_api_availability.dart';

void main() => runApp(const MyApp());

///Creates the mutable state for this widget
class MyApp extends StatefulWidget {
  ///Named [key] parameter to identify a widget
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GooglePlayServicesAvailability _playStoreAvailability =
      GooglePlayServicesAvailability.unknown;
  bool _madeGooglePlayServiceAvailable = false;
  String _errorString = "unknown";
  bool _isUserResolvable = false;
  bool _errorNotificationShown = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkPlayServices([bool showDialog = false]) async {
    GooglePlayServicesAvailability playStoreAvailability;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      playStoreAvailability = await GoogleApiAvailability.instance
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
    bool madeGooglePlayServiceAvailable;

    try {
      madeGooglePlayServiceAvailable = await GoogleApiAvailability.instance
          .makeGooglePlayServicesAvailable();
    } on PlatformException {
      madeGooglePlayServiceAvailable = false;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _madeGooglePlayServiceAvailable = madeGooglePlayServiceAvailable;
    });
  }

  Future<void> getErrorString() async {
    String errorString;

    try {
      errorString = await GoogleApiAvailability.instance.getErrorString();
    } on PlatformException {
      errorString = "Not available on non Android devices";
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
          await GoogleApiAvailability.instance.isUserResolvable();
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
    bool errorNotificationShown;

    try {
      errorNotificationShown =
          await GoogleApiAvailability.instance.showErrorNotification();
    } on PlatformException {
      errorNotificationShown = false;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _errorNotificationShown = errorNotificationShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(
            children: <Widget>[
              MaterialButton(
                onPressed: () => checkPlayServices(),
                child: const Text('Get PlayServices availability'),
                color: Colors.red,
              ),
              Center(
                  child: Text(
                      'Google Play Store status: ${_playStoreAvailability.toString().split('.').last}\n')),
              MaterialButton(
                onPressed: () => checkPlayServices(true),
                child:
                    const Text('Get PlayServices availability with fix dialog'),
                color: Colors.redAccent,
              ),
              Center(
                  child: Text(
                      'Google Play Store status: ${_playStoreAvailability.toString().split('.').last}\n')),
              MaterialButton(
                onPressed: () => makeGooglePlayServicesAvailable(),
                child: const Text('Set Google Play Service to availabe'),
                color: Colors.red,
              ),
              Center(
                  child: Text(
                      'Made available: $_madeGooglePlayServiceAvailable\n')),
              MaterialButton(
                onPressed: () => getErrorString(),
                child: const Text('Get string of the error code'),
                color: Colors.red,
              ),
              Center(child: Text('Error string: $_errorString\n')),
              MaterialButton(
                onPressed: () => isUserResolvable(),
                child: const Text('Error resolvable by user'),
                color: Colors.red,
              ),
              Center(
                  child:
                      Text('Error resolvable by user: $_isUserResolvable\n')),
              MaterialButton(
                onPressed: () => showErrorNotification(),
                child: const Text('Show error notification'),
                color: Colors.red,
              ),
              Center(
                  child: Text(
                      'Error notification shown: $_errorNotificationShown\n')),
            ],
          )),
    );
  }
}
