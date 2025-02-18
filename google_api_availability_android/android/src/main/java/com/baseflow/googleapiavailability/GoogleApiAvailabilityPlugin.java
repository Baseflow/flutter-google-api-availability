package com.baseflow.googleapiavailability;

import android.content.Context;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

/**
 * GoogleApiAvailabilityPlugin
 */
public class GoogleApiAvailabilityPlugin implements FlutterPlugin, ActivityAware {

  private final GoogleApiAvailabilityManager googleApiAvailabilityManager;
  private MethodChannel channel;
  private MethodCallHandlerImpl methodCallHandler;

  public GoogleApiAvailabilityPlugin() {
      this.googleApiAvailabilityManager = new GoogleApiAvailabilityManager();
  }

  @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
      if (methodCallHandler != null) {
        methodCallHandler.setActivity(binding.getActivity());
      }
    }

    @Override
    public void onDetachedFromActivity() {
      if (methodCallHandler != null) {
        methodCallHandler.setActivity(null);
      }
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
      if (methodCallHandler != null) {
        methodCallHandler.setActivity(binding.getActivity());
      }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
      if (methodCallHandler != null) {
        methodCallHandler.setActivity(null);
      }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
      registerPlugin(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    unregisterPlugin();
  }

  private void registerPlugin(Context context, BinaryMessenger messenger) {
    methodCallHandler = new MethodCallHandlerImpl(context, googleApiAvailabilityManager);
    channel = new MethodChannel(messenger, "flutter.baseflow.com/google_api_availability_android/methods");
    channel.setMethodCallHandler(methodCallHandler);
  }

  private void unregisterPlugin() {
    if (channel != null) {
      channel.setMethodCallHandler(null);
      channel = null;
    }
  }
}