package com.example.write_native_code_exampel

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import org.opencv.android.OpenCVLoader
import org.opencv.android.Utils
import org.opencv.core.Mat
import org.opencv.imgproc.Imgproc

class MainActivity : FlutterActivity() {
    private val CHANNEL = "opencv_channel"

    init {
        // Load OpenCV native library
        if (!OpenCVLoader.initLocal()) {
            Log.e("OpenCV", "OpenCV initialization failed")
        } else {
            Log.d("OpenCV", "OpenCV initialized successfully")
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "processImage") {
                val imageBytes = call.arguments as ByteArray
                val processedBytes = processImageWithOpenCV(imageBytes)
                if (processedBytes != null) {
                    result.success(processedBytes)
                } else {
                    result.error("ERROR", "Failed to process image", null)
                }
            }
        }
    }

    private fun processImageWithOpenCV(imageBytes: ByteArray): ByteArray? {
        try {
            // Convert ByteArray to Bitmap
            val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)

            // Convert Bitmap to OpenCV Mat
            val mat = Mat()
            Utils.bitmapToMat(bitmap, mat)

            // Convert to grayscale
            val grayMat = Mat()
            Imgproc.cvtColor(mat, grayMat, Imgproc.COLOR_BGR2GRAY)

            // Convert Mat back to Bitmap
            val grayBitmap =
                    Bitmap.createBitmap(grayMat.cols(), grayMat.rows(), Bitmap.Config.ARGB_8888)
            Utils.matToBitmap(grayMat, grayBitmap)

            // Convert Bitmap to ByteArray
            val stream = ByteArrayOutputStream()
            grayBitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
            return stream.toByteArray()
        } catch (e: Exception) {
            e.printStackTrace()
            return null
        }
    }
}
