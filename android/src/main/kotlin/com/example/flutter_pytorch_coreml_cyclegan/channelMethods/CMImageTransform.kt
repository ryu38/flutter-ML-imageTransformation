package com.example.flutter_pytorch_coreml_cyclegan.channelMethods

import com.example.flutter_pytorch_coreml_cyclegan.pytorch.MLProcessor
import com.example.flutter_pytorch_coreml_cyclegan.pytorch.MLProcessorImpl
import com.example.flutter_pytorch_coreml_cyclegan.utils.BitmapProcessor
import com.example.flutter_pytorch_coreml_cyclegan.utils.BitmapProcessorImpl

object CMImageTransform {

    private val bitmapProcessor: BitmapProcessor = BitmapProcessorImpl()
    private var MLProcessor: MLProcessor? = null

    fun main(imagePath: String, modelPath: String, outputPath: String): String? {
        try {
            val srcBitmap = bitmapProcessor.loadImage(imagePath)
            val input = bitmapProcessor.centerCropScale(srcBitmap, WIDTH, HEIGHT)
            if (MLProcessor == null) {
                MLProcessor = MLProcessorImpl(modelPath)
            }
            MLProcessor!!.process(input).also {
                bitmapProcessor.saveBitmap(it, outputPath)
            }
            return null
        } catch (ex: Exception) {
            return ex.message ?: "unknown"
        }
    }

    const val WIDTH = 256
    const val HEIGHT = 256
}