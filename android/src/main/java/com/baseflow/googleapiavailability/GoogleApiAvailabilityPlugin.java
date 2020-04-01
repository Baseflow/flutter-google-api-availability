package com.baseflow.googleapiavailability;

import android.content.Context;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry.ViewDestroyListener;
import io.flutter.view.FlutterNativeView;

/**
 * GoogleApiAvailabilityPlugin
 */
public class GoogleApiAvailabilityPlugin implements FlutterPlugin, ActivityAware {

  private MethodChannel channel;
  private MethodCallHandlerImpl methodCallHandler;

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    methodCallHandler.setActivity(binding.getActivity());
  }

  @Override
  public void onDetachedFromActivity() {
    methodCallHandler.setActivity(null);
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    methodCallHandler.setActivity(binding.getActivity());
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    methodCallHandler.setActivity(null);
  }

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    registerPlugin(binding.getApplicationContext(), binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    unregisterPlugin();
  }

  public static void registerWith(Registrar registrar) {
    final GoogleApiAvailabilityPlugin plugin = new GoogleApiAvailabilityPlugin();
    plugin.registerPlugin(registrar.context(), registrar.messenger());
    plugin.methodCallHandler.setActivity(registrar.activity());

    registrar.addViewDestroyListener(new ViewDestroyListener() {
      @Override
      public boolean onViewDestroy(FlutterNativeView view) {
        plugin.unregisterPlugin();
        return false;
      }
    });
  }

  private void registerPlugin(Context context, BinaryMessenger messenger) {
    methodCallHandler = new MethodCallHandlerImpl(context);
    channel = new MethodChannel(messenger, "flutter.baseflow.com/google_api_availability/methods");
    channel.setMethodCallHandler(methodCallHandler);
  }

  private void unregisterPlugin() {
    channel.setMethodCallHandler(null);
    channel = null;
  }
}