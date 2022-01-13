package com.example.flutter_ml_image_transformation.channelMethods

import com.example.flutter_ml_image_transformation.pytorch.MLProcessor
import com.example.flutter_ml_image_transformation.pytorch.MLProcessorImpl
import com.example.flutter_ml_image_transformation.utils.BitmapProcessor
import com.example.flutter_ml_image_transformation.utils.BitmapProcessorImpl
import com.example.flutter_ml_image_transformation.utils.ImageFileUtils
import io.flutter.Log

object CMImageTransform {

    private val bitmapProcessor: BitmapProcessor = BitmapProcessorImpl()
    private var mlProcessor: MLProcessor? = null

    fun setModel(modelPath: String, width: Int, height: Int): String? {
        try {
            mlProcessor = MLProcessorImpl(modelPath, width, height)
        } catch (ex: Exception) {
            return ex.message ?: "unknown"
        }
        return null
    }

    fun transformImage(
        imagePath: String, outputPath: String): String? {
        try {
            mlProcessor?.let {
                val srcBitmap = bitmapProcessor.loadImage(imagePath)
                val rotation = ImageFileUtils.getRotation(imagePath)
                val input = bitmapProcessor.centerCropScaleRotate(
                    srcBitmap, it.width, it.height, rotate = rotation.toFloat())
                it.process(input).also {
                    bitmapProcessor.saveBitmap(it, outputPath)
                    return null
                }
            }
            throw Exception("a model is not set")
        } catch (ex: Exception) {
            return ex.message ?: "unknown"
        }
    }
}
