package com.example.niggerracing

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.niggerracing/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "launchNativeScreen") {
                launchNativeScreen()
                result.success(null) // Signal that the method was handled successfully
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchNativeScreen() {
        // Here, you can start a new Android activity or perform any other native functionality.
        // Example: Launching a new activity
        val intent = Intent(this, NativePageActivity::class.java)
        startActivity(intent)
    }
}
