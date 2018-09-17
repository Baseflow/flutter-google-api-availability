import Flutter
import UIKit
    
public class SwiftGoogleApiAvailabilityPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "google_api_availability", binaryMessenger: registrar.messenger())
    let instance = SwiftGoogleApiAvailabilityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "checkPlayServicesAvailability" {
      result(false)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
