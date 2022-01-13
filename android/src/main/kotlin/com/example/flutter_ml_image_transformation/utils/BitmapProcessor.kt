package com.example.flutter_ml_image_transformation.utils

import android.graphics.Bitmap

interface BitmapProcessor {

    fun loadImage(path: String): Bitmap

    fun saveBitmap(bitmap: Bitmap, path: String)

    fun centerCropScaleRotate(
        src: Bitmap, width: Int, height: Int, rotate: Float? = null): Bitmap
}