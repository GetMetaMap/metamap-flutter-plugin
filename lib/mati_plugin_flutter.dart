import 'dart:async';

import 'package:flutter/services.dart';

class MatiFlutter {
  static final resultCompleter = Completer<Result>();

  static const MethodChannel _channel = const MethodChannel('mati_flutter');

  static Future<String> showMatiFlow(String clientId, String flowId, Map<String, dynamic> metadata) async {
  _channel.setMethodCallHandler(handler);
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
          resultCompleter.complete(ResultSuccess(call.arguments as String));
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
  ResultSuccess(this.verificationId);
}

class ResultCancelled extends Result {

}