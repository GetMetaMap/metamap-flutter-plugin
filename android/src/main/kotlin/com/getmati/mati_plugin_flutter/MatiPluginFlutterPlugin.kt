package com.getmati.mati_plugin_flutter

import android.app.Activity
import android.graphics.Color
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import com.metamap.metamap_sdk.MetamapSdk
import com.metamap.metamap_sdk.Metadata
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
      if (requestCode == MetamapSdk.DEFAULT_REQUEST_CODE) {
        if (resultCode == Activity.RESULT_OK) {
          val result = data?.getStringExtra("ARG_VERIFICATION_ID") +" "+ data?.getStringExtra("ARG_IDENTITY_ID")
          channel.invokeMethod("success", result)
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
      "showMatiFlow" -> {
        clientId = call.argument("clientId")!!
        flowId = call.argument("flowId")
        metadata = call.argument("metadata")

        activity?.let { activity ->
            MetamapSdk.startFlow(activity,
                        clientId,
                        flowId,
            Metadata.Builder().apply {
              metadata?.entries?.forEach {
                  this.with(it.key, if(it.key in arrayOf("buttonColor", "buttonTextColor")) {
                      Color.parseColor(it.value as String)
                  } else {
                      it.value
                  })
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
