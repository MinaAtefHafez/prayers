import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDjjZzMmPfqAB8xbfhXhr2yiEaJ8n5EiDg")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
