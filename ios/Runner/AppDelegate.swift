import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
       // TODO: Add your Google Maps API key
            GMSServices.provideAPIKey("AIzaSyA6QI378BHt9eqBbiJKtqWHTSAZxcSwN3Q")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
