package com.example.flutter_ml_image_transformation.pytorch

import android.graphics.Bitmap
import org.pytorch.Module

interface MLProcessor {

    val module: Module
    val width: Int
    val height: Int

    fun process(bitmap: Bitmap): Bitmap
}