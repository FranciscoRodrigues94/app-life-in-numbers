package com.lifeinnumbers.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "com.lifeinnumbers.app/quick_track"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getPendingActions" -> {
                        result.success(QuickTrackActionStore.pending(this))
                    }
                    "acknowledgeAction" -> {
                        val id = call.argument<String>("id")
                        if (id.isNullOrBlank()) {
                            result.error("INVALID_ID", "Missing action ID", null)
                        } else {
                            result.success(QuickTrackActionStore.acknowledge(this, id))
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
