package com.example.flutter_ml_image_transformation.channelMethods

import com.example.flutter_ml_image_transformation.pytorch.MLProcessor
import com.example.flutter_ml_image_transformation.pytorch.MLProcessorImpl
import com.example.flutter_ml_image_transformation.utils.BitmapProcessor
import com.example.flutter_ml_image_transformation.utils.BitmapProcessorImpl
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

object CMImageTransform {

    private val bitmapProcessor: BitmapProcessor = BitmapProcessorImpl()
    private var mlProcessor: MLProcessor? = null

    suspend fun setModel(modelPath: String, width: Int, height: Int): String? {
        try {
            mlProcessor = withContext(Dispatchers.IO) {
                MLProcessorImpl(modelPath, width, height)
            }
        } catch (ex: Exception) {
            return ex.message ?: "unknown"
        }
        return null
    }

    suspend fun transformImage(
        imagePath: String, outputPath: String): String? {
        try {
            mlProcessor?.let {
                withContext(Dispatchers.Default) {
                    val srcBitmap = bitmapProcessor.loadImage(imagePath)
                    val input = bitmapProcessor.centerCropScale(
                        srcBitmap, it.width, it.height)
                    it.process(input).also {
                        bitmapProcessor.saveBitmap(it, outputPath)
                    }
                }
                return null
            }
            throw Exception("a model is not set")
        } catch (ex: Exception) {
            return ex.message ?: "unknown"
        }
    }
}
