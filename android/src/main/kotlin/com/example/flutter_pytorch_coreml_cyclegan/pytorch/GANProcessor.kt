package com.example.flutter_pytorch_coreml_cyclegan.pytorch

import android.graphics.Bitmap

interface GANProcessor {

    fun process(bitmap: Bitmap): Bitmap
}