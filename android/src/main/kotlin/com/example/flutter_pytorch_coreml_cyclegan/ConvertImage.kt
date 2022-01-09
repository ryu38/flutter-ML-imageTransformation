package com.example.flutter_pytorch_coreml_cyclegan

import com.example.flutter_pytorch_coreml_cyclegan.pytorch.GANProcessor
import com.example.flutter_pytorch_coreml_cyclegan.pytorch.GANProcessorImpl
import com.example.flutter_pytorch_coreml_cyclegan.utils.BitmapProcessor
import com.example.flutter_pytorch_coreml_cyclegan.utils.BitmapProcessorImpl

object ConvertImage {

    private val bitmapProcessor: BitmapProcessor = BitmapProcessorImpl()
    private var ganProcessor: GANProcessor? = null

    fun main(imagePath: String, modelPath: String, outputPath: String): Boolean {
        val srcBitmap = bitmapProcessor.loadImage(imagePath)
        val input = bitmapProcessor.centerCropScale(srcBitmap, WIDTH, HEIGHT)
        if (ganProcessor == null) {
            ganProcessor = GANProcessorImpl(modelPath)
        }
        ganProcessor?.process(input)?.also {
            bitmapProcessor.saveBitmap(it, outputPath)
            return true
        }
        return false
    }

    const val WIDTH = 256
    const val HEIGHT = 256
}