import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:metamap_plugin_flutter/Result.dart';

class MetaMapFlutter {
  static const MethodChannel _channel = MethodChannel('mati_flutter');
  static Completer<Result>? _resultCompleter;

  /// Optional callback for when 'created' event is received
  static void Function(ResultCreated result)? onCreated;

  /// Start the MetaMap flow and wait for the result
  ///
  /// Phone verification defaults can be passed through [metadata]:
  /// - `phoneNumber`: national phone number used as the default on the phone
  ///   verification step (e.g. "5551234567").
  /// - `phoneCountryCode`: ISO 3166-1 alpha-2 country code for the phone
  ///   verification step (e.g. "US", "MX").
  static Future<Result> showMetaMapFlow({
    required String clientId,
    required String flowId,
    String? configurationId,
    String? encryptionConfigurationId,
    Map<String, dynamic>? metadata,
  }) async {
    // Prevent multiple concurrent flows
    if (_resultCompleter != null && !_resultCompleter!.isCompleted) {
      _resultCompleter!.completeError(
        StateError("Previous MetaMap flow not completed."),
      );
    }

    _resultCompleter = Completer<Result>();

    // Set up native method handler
    _channel.setMethodCallHandler(_handler);

    // Prepare metadata
    metadata ??= {};
    metadata["sdkType"] = "flutter";

    // Start native flow
    await _channel.invokeMethod('showMatiFlow', {
      'clientId': clientId,
      'flowId': flowId,
      'configurationId': configurationId,
      'encryptionConfigurationId': encryptionConfigurationId,
      'metadata': metadata,
    });

    // Wait for success/cancelled result
    return _resultCompleter!.future;
  }

  /// Handle messages from iOS/Android native layer
  static Future<void> _handler(MethodCall call) async {
    final text = call.arguments as String;
    final parts = text.trim().split(' ');
    final verificationId = parts.isNotEmpty ? parts[0] : "";
    final identityId = parts.length > 1 ? parts[1] : "";

    log("📡 Received method: ${call.method}, arguments: $text");

    switch (call.method) {
      case "created":
        log("🟡 Forwarding 'created' to app via onCreated");
        onCreated?.call(ResultCreated(verificationId, identityId));
        break;

      case "success":
        if (!(_resultCompleter?.isCompleted ?? true)) {
          log("✅ Completing with ResultSuccess");
          _resultCompleter!.complete(ResultSuccess(verificationId, identityId));
        } else {
          log("⚠️ Ignored duplicate 'success' event.");
        }
        break;

      case "cancelled":
        if (!(_resultCompleter?.isCompleted ?? true)) {
          log("🚫 Completing with ResultCancelled");
          _resultCompleter!
              .complete(ResultCancelled(verificationId, identityId));
        } else {
          log("⚠️ Ignored duplicate 'cancelled' event.");
        }
        break;

      default:
        throw MissingPluginException('❌ Unhandled method: ${call.method}');
    }
  }
}
