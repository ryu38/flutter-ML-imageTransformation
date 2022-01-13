package com.example.flutter_ml_image_transformation.utils

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import java.io.ByteArrayOutputStream
import java.io.File

class BitmapProcessorImpl: BitmapProcessor {

    override fun loadImage(path: String): Bitmap {
        return BitmapFactory.decodeFile(path)
    }

    override fun saveBitmap(bitmap: Bitmap, path: String) {
        val baos = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos)
        val jpgArray = baos.toByteArray()
        File(path).writeBytes(jpgArray)
    }

    override fun centerCropScaleRotate(
        src: Bitmap, width: Int, height: Int, rotate: Float?): Bitmap {

        val srcWidth = src.width
        val srcHeight = src.height

        val srcAspect = srcHeight.toFloat() / srcWidth
        val cropAspect = height.toFloat() / width

        val matrix = { srcW: Int, srcH: Int ->
            Matrix().apply {
                postScale(width.toFloat() / srcW, height.toFloat() / srcH)
                rotate?.let { postRotate(it) }
            }
        }

        if (srcAspect > cropAspect) {
            // width ratio larger than original so cut height side
            val cropHeight = (srcWidth * cropAspect).toInt()
            return Bitmap.createBitmap(
                src, 0, (srcHeight - cropHeight) / 2, srcWidth, cropHeight,
                matrix(srcWidth, cropHeight), true)
        } else {
            val cropWidth = (srcHeight / cropAspect).toInt()
            return Bitmap.createBitmap(
                src, (srcWidth - cropWidth) / 2, 0, cropWidth, srcHeight,
                matrix(cropWidth, srcHeight), true)
        }
    }
}