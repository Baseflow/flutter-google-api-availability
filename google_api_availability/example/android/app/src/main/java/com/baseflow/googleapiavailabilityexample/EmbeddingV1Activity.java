package com.baseflow.googleapiavailabilityexample;

import android.os.Bundle;
import com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin;
import io.flutter.app.FlutterActivity;

public class EmbeddingV1Activity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GoogleApiAvailabilityPlugin
        .registerWith(
            registrarFor("com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin"));
  }
}