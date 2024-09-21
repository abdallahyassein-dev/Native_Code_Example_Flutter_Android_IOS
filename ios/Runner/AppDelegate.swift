import UIKit
import Flutter
import CoreMotion

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    var motionManager: CMMotionManager!
    var eventSink: FlutterEventSink?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller = window?.rootViewController as! FlutterViewController
        let accelerometerChannel = FlutterEventChannel(name: "com.example.accelerometer/data",
                                                        binaryMessenger: controller.binaryMessenger)
        accelerometerChannel.setStreamHandler(self)
        
        motionManager = CMMotionManager()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        
        // Start sending accelerometer data
        startAccelerometerUpdates()
        
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // Stop sending data when the listener cancels
        stopAccelerometerUpdates()
        eventSink = nil
        return nil
    }
    
    private func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1 // Set update interval
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                guard let data = data, error == nil else { return }
                let accelerometerData: [String: Double] = [
                    "x": data.acceleration.x,
                    "y": data.acceleration.y,
                    "z": data.acceleration.z
                ]
                self.eventSink?(accelerometerData) // Send data to Flutter
            }
        }
    }

    private func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }
}
