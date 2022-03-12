import Flutter
import UIKit
import MatiSDK

public class SwiftMatiPluginFlutterPlugin: NSObject, FlutterPlugin, MatiButtonResultDelegate {
  
    let channel: FlutterMethodChannel
    
    init(_ channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mati_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftMatiPluginFlutterPlugin(channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "showMatiFlow") {
              let arguments = (call.arguments as! [String: Any])
            let clientId = arguments["clientId"] as! String
            let flowId = arguments["flowId"] as? String
            let metadata = arguments["metadata"] as? [String : Any]
            
            Mati.shared.showMatiFlow(clientId: clientId,
                                    flowId: flowId,
                                    metadata: metadata)

            MatiButtonResult.shared.delegate = self

            result("startVerification: " + UIDevice.current.systemVersion)
        } else {
            result("otherMethod: " + UIDevice.current.systemVersion)
        }
    }
    
     public func verificationSuccess(identityId: String?, verificationID: String?) {
          self.channel.invokeMethod("success", arguments: (identityId ?? "") + " " + (verificationID ?? ""))
       }
    
    public func verificationCancelled() {
        self.channel.invokeMethod("cancelled", arguments: nil)
    }
}
