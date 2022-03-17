import Flutter
import UIKit
import MetaMapSDK

public class SwiftMetaMapPluginFlutterPlugin: NSObject, FlutterPlugin, MetaMapButtonResultDelegate {
  
    let channel: FlutterMethodChannel
    
    init(_ channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mati_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftMetaMapPluginFlutterPlugin(channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "showMatiFlow") {
              let arguments = (call.arguments as! [String: Any])
            let clientId = arguments["clientId"] as! String
            let flowId = arguments["flowId"] as? String
            let metadata = arguments["metadata"] as? [String : Any]
            
            MetaMap.shared.showMetaMapFlow(clientId: clientId,
                                    flowId: flowId,
                                    metadata: metadata)

            MetaMapButtonResult.shared.delegate = self

            result("startVerification: " + UIDevice.current.systemVersion)
        } else {
            result("otherMethod: " + UIDevice.current.systemVersion)
        }
    }
    
     public func verificationSuccess(identityId: String?, verificationID: String?) {
          self.channel.invokeMethod("success", arguments: (verificationID ?? "") + " " + (identityId ?? ""))
       }
    
    public func verificationCancelled() {
        self.channel.invokeMethod("cancelled", arguments: nil)
    }
}
