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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _madeGooglePlayServiceAvailable = madeGooglePlayServiceAvailable;
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
                      'Google Play Store status: ${_playStoreAvailability.toString().split('.').last}\n')
              ),
              MaterialButton(
                onPressed: () => makeGooglePlayServicesAvailable(),
                child: const Text('Set Google Play Service to availabe'),
                color: Colors.red,
              ),
              Center(
                  child: Text(
                      'Make available: $_madeGooglePlayServiceAvailable\n')),
              MaterialButton(
                onPressed: () => checkPlayServices(true),
                child:
                    const Text('Get PlayServices availability with fix dialog'),
                color: Colors.redAccent,
              ),
            ],
          )),
    );
  }
}
