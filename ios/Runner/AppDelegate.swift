import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController

    // Registering the platform view
    let factory = GoogleMapViewFactory()
    registrar(forPlugin: "com.example.google_maps/native_map_view")?.register(
      factory,
      withId: "com.example.google_maps/native_map_view"
    )

    GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// Define the factory for creating the native Google Map view
class GoogleMapViewFactory: NSObject, FlutterPlatformViewFactory {
  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    return GoogleMapView(frame: frame, creationParams: args as? [String: Any])
  }
}

// Define the custom platform view
class GoogleMapView: NSObject, FlutterPlatformView {
  let mapView: GMSMapView

  init(frame: CGRect, creationParams: [String: Any]?) {
    // Initialize the Google Maps view with a default frame
    self.mapView = GMSMapView(frame: frame)
    
    super.init()

    if let params = creationParams {
      // Retrieve latitude, longitude, and zoom from creationParams
      let latitude = params["latitude"] as? CLLocationDegrees ?? 37.7749
      let longitude = params["longitude"] as? CLLocationDegrees ?? -122.4194
      let zoom = params["zoom"] as? Float ?? 12.0

      // Set the camera position
      let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
      mapView.camera = camera
    }
  }

  func view() -> UIView {
    return mapView
  }
}
