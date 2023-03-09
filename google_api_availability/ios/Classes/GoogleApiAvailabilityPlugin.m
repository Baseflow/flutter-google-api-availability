#import "GoogleApiAvailabilityPlugin.h"

@implementation GoogleApiAvailabilityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter.baseflow.com/google_api_availability/methods"
            binaryMessenger:[registrar messenger]];
  GoogleApiAvailabilityPlugin* instance = [[GoogleApiAvailabilityPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"checkPlayServicesAvailability" isEqualToString:call.method]) {
    result(@false);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
