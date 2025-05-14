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
            print("📲 Received 'showMatiFlow' call from Flutter")

            let arguments = (call.arguments as! [String: Any])
            let clientId = arguments["clientId"] as! String
            let flowId = arguments["flowId"] as? String
            let configurationId = arguments["configurationId"] as? String
            let encryptionConfigurationId = arguments["encryptionConfigurationId"] as? String
            let metadata = arguments["metadata"] as? [String : Any]

            print("🧾 Parsed arguments: clientId=\(clientId), flowId=\(flowId ?? "nil")")

            MetaMap.shared.showMetaMapFlow(clientId: clientId,
                                           flowId: flowId,
                                           configurationId: configurationId,
                                           encryptionConfigurationId: encryptionConfigurationId,
                                           metadata: metadata)

            MetaMapButtonResult.shared.delegate = self
            print("✅ Set MetaMapButtonResult delegate")

            result("startVerification: " + UIDevice.current.systemVersion)
        } else {
            print("⚠️ Received unknown method: \(call.method)")
            result("otherMethod: " + UIDevice.current.systemVersion)
        }
    }

    public func verificationSuccess(identityId: String?, verificationID: String?) {
        print("🎉 verificationSuccess called with identityId=\(identityId ?? "nil"), verificationID=\(verificationID ?? "nil")")
        self.channel.invokeMethod("success", arguments: (verificationID ?? "") + " " + (identityId ?? ""))
    }

    public func verificationCancelled(identityId: String?, verificationID: String?) {
        print("❌ verificationCancelled called with identityId=\(identityId ?? "nil"), verificationID=\(verificationID ?? "nil")")
        self.channel.invokeMethod("cancelled", arguments: (verificationID ?? "") + " " + (identityId ?? ""))
    }

    public func verificationCreated(identityId: String?, verificationID: String?) {
        print("🆕 verificationCreated called with identityId=\(identityId ?? "nil"), verificationID=\(verificationID ?? "nil")")
        self.channel.invokeMethod("created", arguments: (verificationID ?? "") + " " + (identityId ?? ""))
    }
}
