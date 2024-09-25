package com.example.nfc_practice

//import io.flutter.embedding.android.FlutterActivity

//package com.example.card_reader

//package com.example.nfc_practice

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.nfc_practice/swipe"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Check if flutterEngine is available
        flutterEngine?.let {
            MethodChannel(it.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "readCard") {
                    val cardData = readSwipeCard()
                    if (cardData != null) {
                        result.success(cardData)
                    } else {
                        result.error("UNAVAILABLE", "Card data not available", null)
                    }
                } else {
                    result.notImplemented()
                }
            }
        } ?: run {
            // Handle case when flutterEngine is null
            // You can log an error or provide feedback to the user
            println("Flutter engine is not initialized")
        }
    }

    // Mock function to read swipe card data
    private fun readSwipeCard(): String? {
        // Implement actual logic for reading card data
        return "Card Data: 1234-5678-9012-3456"  // Mock data
    }
}


