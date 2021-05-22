package com.getmati.mati_plugin_flutter

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import com.getmati.mati_sdk.MatiSdk
import com.getmati.mati_sdk.Metadata
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class MatiPluginFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel: MethodChannel

  private var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mati_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    binding.addActivityResultListener { requestCode, resultCode, data ->
      if (requestCode == MatiSdk.REQUEST_CODE) {
        if (resultCode == Activity.RESULT_OK) {
          channel.invokeMethod("success", data.getStringExtra("ARG_VERIFICATION_ID"))
        } else {
          channel.invokeMethod("cancelled", null)
        }
        true
      }
      false
    }
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  private var clientId: String = ""
  private var flowId: String? = null
  private var metadata: Map<String, Any>? = null

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "startVerification" -> {
        clientId = call.argument("clientId")!!
        flowId = call.argument("flowId")
        metadata = call.argument("metadata")
        result.success("startVerification ${android.os.Build.VERSION.RELEASE}")
      }
      "showMatiFlow" -> {
        activity?.let { activity ->
          MatiSdk.startFlow(
            activity,
            clientId,
            flowId,
            Metadata.Builder().apply {
              metadata?.entries?.forEach {
                this.with(it.key, it.value)
              }
            }.build()
          )

          result.success("showMatiFlow ${android.os.Build.VERSION.RELEASE}")
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
