package com.baseflow.googleapiavailabilityexample;

import android.os.Bundle;
import com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin;
import dev.flutter.plugins.e2e.E2EPlugin;
import io.flutter.app.FlutterActivity;

public class EmbeddingV1Activity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GoogleApiAvailabilityPlugin
        .registerWith(
            registrarFor("com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin"));
    E2EPlugin.registerWith(registrarFor("dev.flutter.plugins.e2e.E2EPlugin"));
  }
}