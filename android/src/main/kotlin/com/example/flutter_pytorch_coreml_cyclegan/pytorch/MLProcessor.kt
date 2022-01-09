package com.example.flutter_pytorch_coreml_cyclegan.pytorch

import android.graphics.Bitmap

interface MLProcessor {

    fun process(bitmap: Bitmap): Bitmap
}