package com.example.flutter_pytorch_coreml_cyclegan.pytorch

import android.graphics.Bitmap
import org.pytorch.Module

interface MLProcessor {

    val module: Module
    val width: Int
    val height: Int

    fun process(bitmap: Bitmap): Bitmap
}