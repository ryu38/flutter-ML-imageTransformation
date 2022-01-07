package com.example.flutter_pytorch_coreml_cyclegan.utils

import android.graphics.Bitmap

interface BitmapProcessor {

    fun loadImage(path: String): Bitmap

    fun saveBitmap(bitmap: Bitmap, path: String)

    fun centerCropScale(src: Bitmap, width: Int, height: Int): Bitmap
}