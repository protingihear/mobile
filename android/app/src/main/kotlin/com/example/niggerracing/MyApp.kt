package com.example.niggerracing

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApp : Application() {
    lateinit var flutterEngine: FlutterEngine

    override fun onCreate() {
        super.onCreate()

        // Initialize the Flutter engine
        flutterEngine = FlutterEngine(this).apply {
            // Start executing Dart code to allow the MethodChannel to work
            dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )
        }

        // Cache the Flutter engine for later use in activities
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
    }
}
