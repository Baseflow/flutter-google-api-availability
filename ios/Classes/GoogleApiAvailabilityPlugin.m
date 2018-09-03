#import "GoogleApiAvailabilityPlugin.h"
#import <google_api_availability/google_api_availability-Swift.h>

@implementation GoogleApiAvailabilityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGoogleApiAvailabilityPlugin registerWithRegistrar:registrar];
}
@end
