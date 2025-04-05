import 'dart:async';

import 'package:flutter/services.dart';

class MetaMapFlutter {
  static var resultCompleter;

  static const MethodChannel _channel = const MethodChannel('mati_flutter');

  static Future<String> showMetaMapFlow(
      {required String clientId,
      required String flowId,
      String? configurationId,
      String? encryptionConfigurationId,
      Map<String, dynamic>? metadata}) async {
    _channel.setMethodCallHandler(handler);
    resultCompleter = Completer<Result>();
    metadata?["sdkType"] = "flutter";

    return await _channel.invokeMethod('showMatiFlow', <String, dynamic>{
      'clientId': clientId,
      'flowId': flowId,
      'configurationId': configurationId,
      'encryptionConfigurationId': encryptionConfigurationId,
      'metadata': metadata,
    });
  }

  static Future<Result?> handler(MethodCall call) async {
    switch (call.method) {
      case "cancelled":
        String text = call.arguments;
        List<String> result = text.split(' ');
        String verificationId = result[0];
        String identityId = result[1];
        resultCompleter.complete(ResultCancelled(verificationId, identityId));
        return null;
      case "success":
        String text = call.arguments;
        List<String> result = text.split(' ');
        String verificationId = result[0];
        String identityId = result[1];
        resultCompleter.complete(ResultSuccess(verificationId, identityId));
        return null;
      default:
        throw MissingPluginException('notImplemented');
    }
  }
}

abstract class Result {}

class ResultSuccess extends Result {
  final String verificationId;
  final String identityId;

  ResultSuccess(this.verificationId, this.identityId);
}

class ResultCancelled extends Result {
  final String verificationId;
  final String identityId;

  ResultCancelled(this.verificationId, this.identityId);
}
