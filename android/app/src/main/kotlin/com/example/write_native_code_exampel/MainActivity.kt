package com.example.write_native_code_exampel


import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.native/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "calculateSum") {
                // Extract the double values
                val num1: Double = call.argument<Double>("num1") ?: 0.0
                val num2: Double = call.argument<Double>("num2") ?: 0.0

                // Calculate the sum
                val sum = num1 + num2

                // Return the result to Flutter
                result.success(sum)
            }
            else if (call.method == "getMyFullName"){
                val firstName: String = call.argument<String>("first_name") ?: ""
                val lastName: String = call.argument<String>("last_name") ?: ""

                val fullName = "Your Full Name is : " + firstName + " " + lastName

                result.success(fullName)
            }
            else {
                result.notImplemented()
            }
        }
    }
}