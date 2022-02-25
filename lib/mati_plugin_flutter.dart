import 'dart:async';
import 'package:flutter/services.dart';

class MetaMapFlutter {
  static var resultCompleter;

  static const MethodChannel _channel = const MethodChannel('mati_flutter');

  static Future<String> showMetaMapFlow(String clientId, String flowId, Map<String, dynamic> metadata) async {
  _channel.setMethodCallHandler(handler);
  resultCompleter = Completer<Result>();
  metadata["sdkType"] = "flutter";

  return await _channel.invokeMethod('showMatiFlow', <String, dynamic> {
      'clientId': clientId,
      'flowId': flowId,
      'metadata': metadata,
    });
  }

  static Future<Result?> handler(MethodCall call) async {
    switch (call.method) {
      case "cancelled":
          resultCompleter.complete(ResultCancelled());
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

abstract class Result {

}

class ResultSuccess extends Result {
  final String verificationId;
  final String identittyId;
  ResultSuccess(this.verificationId, this.identittyId);
}

class ResultCancelled extends Result {

}