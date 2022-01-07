package com.example.flutter_pytorch_coreml_cyclegan

import com.example.flutter_pytorch_coreml_cyclegan.pytorch.GANProcessor
import com.example.flutter_pytorch_coreml_cyclegan.pytorch.GANProcessorImpl
import com.example.flutter_pytorch_coreml_cyclegan.utils.BitmapProcessorImpl

object ConvertImage {

    private var ganProcessor: GANProcessor? = null

    fun main(imagePath: String, modelPath: String, outputPath: String): Boolean {
        val srcBitmap = BitmapProcessorImpl.loadImage(imagePath)
        val input = BitmapProcessorImpl.centerCropScale(srcBitmap, WIDTH, HEIGHT)
        if (ganProcessor == null) {
            ganProcessor = GANProcessorImpl(modelPath)
        }
        ganProcessor?.process(input)?.also {
            BitmapProcessorImpl.saveBitmap(it, outputPath)
            return true
        }
        return false
    }

    const val WIDTH = 256
    const val HEIGHT = 256
}