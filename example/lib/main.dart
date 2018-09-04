import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_api_availability/google_api_availability.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GooglePlayServicesAvailability _playStoreAvailability =
      GooglePlayServicesAvailability.unknown;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState([bool showDialog = false]) async {
    GooglePlayServicesAvailability playStoreAvailability;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      playStoreAvailability =
          await GoogleApiAvailability().checkGooglePlayServicesAvailability(showDialog);
    } on PlatformException {
      playStoreAvailability = GooglePlayServicesAvailability.unknown;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _playStoreAvailability = playStoreAvailability;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new ListView(children: <Widget>[
            new MaterialButton(
              onPressed: () => initPlatformState(), 
              child: new Text("Get PlayServices availability"), 
              color: Colors.red,
              ),
            new MaterialButton(
              onPressed: () => initPlatformState(true), 
              child: new Text("Get PlayServices availability with fix dialog"), color: Colors.redAccent,
              ),
            new Center(child: Text('Google Play Store status: ${_playStoreAvailability.toString().split('.').last}\n')),
          ],
        )),
    );
  }
}
